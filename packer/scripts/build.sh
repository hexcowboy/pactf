#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "installing dependencies"
apt-get update #&& apt-get upgrade -y
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# TODO: Change the username
USER="user"
echo "adding new user: $USER"
id -u $USER &>/dev/null || useradd $USER
chown -R $USER:$USER /home/$USER

#
# TODO: Add foothold scripts here
#       eg. Install vulnerable web server, etc
#

#
# TODO: Add privesc scripts here
#       eg. Install vulnerable system binary, etc
#

echo "disabling bash history files"
ln -sf /dev/null /home/$USER/.bash_history
ln -sf /dev/null /root/.bash_history

# TODO: change user and root passwords
echo "setting user and root passwords"
echo "root:password" | chpasswd
echo "$USER:password" | chpasswd

# TODO: Generate 32-character flags with: `openssl rand -hex 16`
echo "adding flags"
echo "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" > /root/root.txt
echo "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" > /home/$USER/user.txt
chmod 0600 /root/root.txt
chmod 0644 /home/$USER/user.txt
chown $USER:$USER /home/$USER/user.txt

echo "cleaning up"
rm -rf /build.sh
rm -rf /root/.cache
rm -rf /root/.viminfo
find /var/log -type f -exec sh -c "cat /dev/null > {}" \;
