# Kickstart for the FIPS build host: RHEL 9, FIPS mode from installation
# (it cannot be switched on properly afterwards), podman and little else.
# Image builds run rootless as `builder`.
# Do not use this file directly: render-ks.sh fills in the registration
# (Secrets Manager `hub-images/rhsm`) and the builder's SSH key, then:
# boot the RHEL 9 installer with  inst.ks=<url of the rendered file> fips=1
# The rendered file holds the activation key: serve it only for the install,
# then delete it. Network: DHCP on VLAN 911, below.

text
lang en_US.UTF-8
keyboard us
timezone UTC --utc
# The first ConnectX port (TORS-A, VLAN 911). Named, because the first
# connected device is the XCC's USB link (169.254.95.x), which has no route.
network --device=ens5f0np0 --bootproto=dhcp --hostname=fips-builder --activate
rootpw --lock
user --name=builder --groups=wheel --lock
sshkey --username=builder "@SSH_PUBKEY@"

zerombr
clearpart --all --initlabel
autopart --type=lvm
bootloader --append="fips=1"

rhsm --organization=@RHSM_ORG@ --activation-key=@RHSM_KEY@

%packages
@^minimal-environment
podman
git-core
rsync
openssh-clients
jq
# AWS CLI v2 (AppStream, RHEL 9.4 and later): the operator's SSO session.
awscli2
%end

%post --log=/root/ks-post.log
# SSH keys only, so sudo cannot ask for a password.
echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder
chmod 0440 /etc/sudoers.d/builder
# The builder runs rootless under this user.
loginctl enable-linger builder || true
%end

reboot
