#!/usr/bin/env python3
"""Secrets Manager access for build.sh, inside the builder container.

  secrets.py get <secret-id> <file>     write the secret (string or binary) to file, mode 0600
  secrets.py put <secret-id> <file>     store file as a binary secret, creating it if needed
"""
import os
import sys

import boto3

cmd, sid, path = sys.argv[1:4]
sm = boto3.client("secretsmanager")
if cmd == "get":
    v = sm.get_secret_value(SecretId=sid)
    data = v["SecretBinary"] if "SecretBinary" in v else v["SecretString"].encode()
    fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(fd, "wb") as f:
        f.write(data)
elif cmd == "put":
    data = open(path, "rb").read()
    try:
        sm.put_secret_value(SecretId=sid, SecretBinary=data)
    except sm.exceptions.ResourceNotFoundException:
        sm.create_secret(Name=sid, SecretBinary=data)
else:
    sys.exit(__doc__)
