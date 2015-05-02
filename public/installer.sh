#! /bin/sh

if [ "$(id -u)" != "0" ]; then
  cat << EOF >&2
Unfortunately, the KeyHub Shim requires root permissions in order to
create user accounts and manage sudoers.  The Shim is open source; please
feel free to audit the code for security.
EOF
  exit 1
fi

if [ "$(uname -s)" != "Linux" ]; then
  echo "Currently, KeyHub supports only Linux systems." >&2
fi

# on older apt-get systems, attempt to install sudo
set +e
apt-get update >/dev/null; apt-get -y install sudo >/dev/null
set -e

echo "Installing KeyHub and halting on errors."


set -e
echo "Creating KeyHub directory (/opt/keyhub/)"
[ -d /opt/keyhub ] && (
  echo "Please remove /opt/keyhub before continuing." >&2; exit -1)
mkdir /opt/keyhub/ || (
  echo "Unable to create directory /opt/keyhub." >&2; exit 1)


echo "Creating uninstall script (/opt/keyhub/uninstall.sh)"
cat << EOF > /opt/keyhub/uninstall.sh
#! /bin/sh +e
# Debian, Ubuntu, RHEL:
sed -i "s/\/opt\/keyhub\/keyhub.sh \&//" \
  /etc/rc.local 2>/dev/null
# SUSE:
sed -i "s/\/opt\/keyhub\/keyhub.sh \&//" \
  /etc/init.d/after.local 2>/dev/null
# # Fedora:
# systemctl disable keyhub-keyhub.service 2>/dev/null
# rm -f /etc/systemd/system/keyhub-keyhub.service 2>/dev/null
rm -Rf /opt/keyhub/
killall keyhub.py keyhub.sh
EOF


if [ "x$api_key" != "x" ]; then
  echo "Creating API login config (/opt/keyhub/creds.py)"
  echo -n > /opt/keyhub/creds.py
  chmod 0600 /opt/keyhub/creds.py
  # create creds configuration file
  cat <<EOF >> /opt/keyhub/creds.py
api_key="$api_key"
EOF
else
  echo "api_key variable not found, skipping creds.py creation."
fi


echo "Creating keyhub (/opt/keyhub/keyhub.{sh,py})"
cat << "EOF" > /opt/keyhub/keyhub.sh
#! /bin/bash +e

[ -z "$PYTHON" ] && PYTHON="$(which python)"
output=$(curl -Ss http://keyhub.dev/keyhub.py | $PYTHON 2>&1)
echo "$output" > /var/log/keyhub.log
# echo "$output" |tee /var/log/keyhub.log

# fix for thundering herd
sleep $(( ( RANDOM % 5 )  + 1 ))

/opt/keyhub/keyhub.sh &

EOF


echo "Removing exit 0 from rc.local"
set +e
sed -i "s/^ *exit 0.*/# &/" /etc/rc.local 2>/dev/null
set -e

echo "Checking Shim Startup"

# most Linux versions can manage with a line added to rc.local:
if [ -f /etc/rc.local ]; then
  distro="Linux"
  fname=/etc/rc.local
elif [ -f /etc/init.d/after.local ]; then
  distro="SUSE"
  fname=/etc/init.d/after.local
# elif [ -f /etc/fedora-release ]; then
#   distro="Fedora"
#   cat << EOF > /etc/systemd/system/keyhub-keyhub.service
# [Unit]
# Description=KeyHub Shim (keyhub.com)
#
# [Service]
# Type=forking
# ExecStart=/opt/keyhub/keyhub.sh
#
# [Install]
# WantedBy=multi-user.target
# EOF
#   systemctl enable keyhub-keyhub.service
else
  cat << EOF >&2
Unable to set start at bootup -- no /etc/rc.local file?
You'll have to set keyhub to startup on it's own: create an
init script that launches /opt/keyhub/keyhub.sh on startup.
In most distributions, this would have been a single line
in /etc/rc.local, but you may need to do something more
exotic. Please contact us with Linux version information
and we may have more information for you.
EOF
  exit 1
fi


set +e
# RHEL7/Fedora hack:
if [ -f /etc/rc.d/rc.local ]; then
  set +e; mv /etc/rc.local /etc/rc.local.old; set -e
  ln -s /etc/rc.d/rc.local /etc/rc.local
fi
set -e


# actually set up the startup
if [ "$distro" != "Fedora" ]; then
  # remove any existing lines:
  set +e
      sed -i "s/\/opt\/keyhub\/keyhub.sh \&//" "$fname" 2>/dev/null
  set -e
  echo "Adding $distro Startup Script to $fname"
  echo >> "$fname"
  echo "/opt/keyhub/keyhub.sh &" >> "$fname"
fi

echo "Setting Permissions"
echo "First run did not complete;
  ensure that /opt/keyhub/keyhub.sh can be executed." > /var/log/keyhub.log
chmod -R 700 \
  /opt/keyhub/ \
  /opt/keyhub/uninstall.sh \
  /opt/keyhub/keyhub.sh \
  /var/log/keyhub.log
set +e
# RHEL7:
chmod +x /etc/rc.d/rc.local
chmod +x /etc/rc.local


echo "Launching keyhub.sh"
set +e;
killall keyhub.py keyhub.sh 2>/dev/null
set -e
/opt/keyhub/keyhub.sh &

echo
echo "Finished. KeyHub has been completely installed."
echo "To remove at any point in the future, run /opt/keyhub/uninstall.sh"
echo "Please check keyhub output in /var/log/keyhub.log"

