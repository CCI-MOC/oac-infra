# Hub Cluster Image Building

Ansible playbook and role for generating OpenShift agent-based installer boot media (ISO or PXE) for OAC hub clusters.

## Prerequisites

- `openshift-install` (or `openshift-install-fips`) binary in your `$PATH`
- `ansible` with `ansible.utils` collection (for `ipaddr` filter)
- SSH keypair in `credentials/<cluster-name>/`
- Pull secret in `group_vars/<cluster-name>/secrets.yml`

## On the FIPS build host (FIPS hubs)

FIPS clusters' boot media can only be made on a host in FIPS mode:
`openshift-install-fips` refuses otherwise. The FIPS build host does it in
one command:

```bash
aws sso login --use-device-code --profile <profile>   # your own session; the host stores no AWS keys
AWS_PROFILE=<profile> ./build.sh compliant-dev-infra
```

It checks the host is in FIPS mode, runs the playbook in a pinned toolchain
image (`builder/`, built on first use for the release in `builder/release`),
fetches the pull secret and the hub's SSH public key from Secrets Manager for
the run only, stores the kubeconfig as `cluster/<name>/kubeadmin`, and copies
the ISO to the bastion's `/srv/boot/<name>-agent.x86_64.iso`. See the comments
in `build.sh` for its settings.

A test run, which changes nothing outside the build host:

```bash
NO_STORE=1 NO_UPLOAD=1 AWS_PROFILE=<profile> ./build.sh compliant-dev-infra
```

Without `NO_STORE=1`, a run replaces the hub's `cluster/<name>/kubeadmin`
with the new, not-yet-installed cluster's kubeconfig; without `NO_UPLOAD=1`,
it replaces the ISO on the bastion.

- **The host:** RHEL 9 installed in FIPS mode from `builder/fips-builder.ks`,
  rendered by `builder/render-ks.sh` with the registration from Secrets
  Manager `hub-images/rhsm` and the builder's SSH key.
  It does not depend on any OpenShift cluster, so it can rebuild a hub when
  none is running.
- **A new OpenShift release:** change `builder/release`; the next run builds
  the image for it.
- **Secrets Manager:** `hub-images/pull-secret` (the pull secret) and
  `cluster/<name>/sshkey` (JSON with `publicKey` and `privateKey`; ECDSA or RSA,
  as FIPS rejects Ed25519).

Without FIPS, or by hand, use the playbook directly:

## Usage

```bash
ansible-playbook -i inventory.yml create_agent_install_media.yaml \
  -e cluster_name=oac-dev-infra
```

To generate PXE boot files instead of an ISO:

```bash
ansible-playbook -i inventory.yml create_agent_install_media.yaml \
  -e cluster_name=oac-dev-infra -e boot_method=pxe
```

## Output

Generated artifacts are written to `output/<cluster-name>/`:

- `work/` - working directory with generated ISO/PXE files and kubeconfig
- `backup/` - backup of manifests before ISO generation consumes them
- `rendered_manifests/` - copy of rendered templates for inspection

## Adding a new cluster

1. Add the cluster to `inventory.yml`
2. Create `group_vars/<cluster-name>/vars.yml` with cluster-specific variables (see `group_vars/examples/vars.yaml.example`)
3. Create `group_vars/<cluster-name>/secrets.yml` (see `group_vars/examples/secrets.yaml.example`)
4. Place SSH keys and pull secret in `credentials/<cluster-name>/`; this directory will be gitignore'd
