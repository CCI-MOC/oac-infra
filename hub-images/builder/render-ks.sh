#!/bin/bash
# Render fips-builder.ks for one install of the FIPS build host.
#   AWS_PROFILE=<profile> ./render-ks.sh ~/.ssh/id_ecdsa.pub > /path/outside/git/fips-builder.ks
# Reads the RHEL registration from Secrets Manager `hub-images/rhsm`
# (JSON: org, activation_key). The output holds the activation key: serve
# it only while the host installs, then delete it.
set -euo pipefail
pub=${1:?usage: render-ks.sh <ssh public key file>}
grep -q -E '^(ecdsa-|ssh-rsa )' "$pub" || { echo "need an ECDSA or RSA key (FIPS rejects Ed25519)" >&2; exit 1; }
here=$(cd "$(dirname "$0")" && pwd)
aws secretsmanager get-secret-value --secret-id hub-images/rhsm \
    --query SecretString --output text |
python3 -c '
import json, sys
rhsm = json.load(sys.stdin)
ks = open(sys.argv[1]).read()
key = open(sys.argv[2]).read().strip()
for k, v in (("@RHSM_ORG@", rhsm["org"]), ("@RHSM_KEY@", rhsm["activation_key"]), ("@SSH_PUBKEY@", key)):
    assert k in ks, k
    ks = ks.replace(k, v)
sys.stdout.write(ks)
' "$here/fips-builder.ks" "$pub"
