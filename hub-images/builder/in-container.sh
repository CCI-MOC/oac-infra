#!/bin/bash
# Runs inside the builder (see build.sh). Fetches the credentials, makes the
# boot media and stores the kubeconfig. Credentials live only for the run.
set -euo pipefail
cluster=$1; boot_method=${2:-iso}
cd /work/hub-images
here=builder

[ "$(cat /proc/sys/crypto/fips_enabled)" = 1 ] || { echo "not a FIPS host" >&2; exit 1; }

creds=credentials/$cluster
mkdir -p -m 0700 "$creds"
trap 'rm -rf "$creds"' EXIT

python3 $here/secrets.py get "${PULL_SECRET_ID:-hub-images/pull-secret}" "$creds/pull-secret.json"
python3 $here/secrets.py get "cluster/$cluster/sshkey" "$creds/key"
# The playbook wants the public key. cluster/<name>/sshkey is JSON with
# publicKey and privateKey; only publicKey is kept.
jq -er .publicKey "$creds/key" > "$creds/$cluster-key.pub"
rm -f "$creds/key"
grep -q '^ssh-ed25519' "$creds/$cluster-key.pub" && { echo "Ed25519 keys do not work under FIPS" >&2; exit 1; }

ansible-playbook -i inventory.yml create_agent_install_media.yaml \
  -e cluster_name="$cluster" -e boot_method="$boot_method"

python3 $here/secrets.py put "cluster/$cluster/kubeadmin" "output/$cluster/work/auth/kubeconfig"
echo "kubeconfig stored as cluster/$cluster/kubeadmin"
