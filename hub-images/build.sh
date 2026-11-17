#!/bin/bash
# Make a hub's boot media on the FIPS build host, end to end:
#
#   ./build.sh <cluster-name> [iso|pxe]
#
# 1. checks this host is in FIPS mode,
# 2. builds the builder image for the release in builder/release, if missing,
# 3. runs the playbook in it, with the pull secret and the hub's SSH public
#    key fetched from Secrets Manager for the run only,
# 4. stores the new kubeconfig as cluster/<name>/kubeadmin,
# 5. copies the ISO to the bastion's /srv/boot/<name>-agent.x86_64.iso.
#
# Needs: the operator's own AWS SSO session for Secrets Manager (log in on
# this host first: aws sso login --use-device-code --profile <profile>), and
# SSH access to the bastion. The host stores no AWS credentials: the session's
# temporary keys are passed into the containers for this run only. Environment overrides: AWS_PROFILE,
# PULL_SECRET_ID (default hub-images/pull-secret), BASTION (default
# 10.2.0.82), BASTION_BOOT_DIR (default /srv/boot), NO_UPLOAD=1.
set -euo pipefail
cluster=${1:?usage: build.sh <cluster-name> [iso|pxe]}
boot_method=${2:-iso}
cd "$(dirname "$0")"
repo=$(cd .. && pwd)

[ "$(cat /proc/sys/crypto/fips_enabled 2>/dev/null)" = 1 ] || {
  echo "This host is not in FIPS mode; FIPS boot media can only be made on one." >&2; exit 1; }
[ -f "group_vars/$cluster/vars.yml" ] || { echo "no group_vars/$cluster/vars.yml" >&2; exit 1; }
if grep -q '"TODO"' "group_vars/$cluster/vars.yml"; then
  echo "group_vars/$cluster/vars.yml still has TODO values" >&2; exit 1
fi

release=$(cat builder/release)
image=localhost/hub-image-builder:$release
# Temporary keys from the operator's session, as environment variables for
# the containers, rather than mounting ~/.aws (an SSO cache in a container
# cannot refresh, and should not leave the host).
creds=$(aws configure export-credentials ${AWS_PROFILE:+--profile "$AWS_PROFILE"} --format env-no-export) || {
  echo "No AWS session: run aws sso login --use-device-code --profile <profile>" >&2; exit 1; }
eval "$creds"; export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
export AWS_REGION=${AWS_REGION:-us-east-1}
aws=(-e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_REGION)

if ! podman image exists "$image"; then
  echo "Building $image"
  ps=$(mktemp); trap 'rm -f "$ps"' EXIT
  podman run --rm "${aws[@]}" -v "$PWD/builder:/b:ro,z" registry.access.redhat.com/ubi9/ubi:latest \
    sh -c 'dnf -q -y install python3-pip >/dev/null && pip3 -q install boto3 && python3 /b/secrets.py get "$0" /dev/stdout' \
    "${PULL_SECRET_ID:-hub-images/pull-secret}" > "$ps"
  podman build --secret id=pull,src="$ps" --build-arg OCP_RELEASE="$release" -t "$image" builder
  rm -f "$ps"
fi

podman run --rm "${aws[@]}" -e PULL_SECRET_ID \
  -v "$repo:/work:z" "$image" /work/hub-images/builder/in-container.sh "$cluster" "$boot_method"

if [ "$boot_method" = iso ] && [ -z "${NO_UPLOAD:-}" ]; then
  dest=${BASTION:-10.2.0.82}:${BASTION_BOOT_DIR:-/srv/boot}/$cluster-agent.x86_64.iso
  rsync -P "output/$cluster/work/agent.x86_64.iso" "$dest"
  echo "ISO at $dest"
fi
