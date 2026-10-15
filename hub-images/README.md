# Hub Cluster Image Building

Ansible playbook and role for generating OpenShift agent-based installer boot media (ISO or PXE) for OAC hub clusters.

## Prerequisites

- `openshift-install` (or `openshift-install-fips`) binary in your `$PATH`
- `ansible` with `ansible.utils` collection (for `ipaddr` filter)
- SSH keypair in `credentials/<cluster-name>/`
- Pull secret in `group_vars/<cluster-name>/secrets.yml`

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
