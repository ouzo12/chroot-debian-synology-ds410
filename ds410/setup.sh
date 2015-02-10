#!/bin/sh
if [ ! -f /usr/local/bin/debian.conf ]; then
echo "debian.conf not found, downloading"
 wget https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/debian.conf -o /usr/local/bin/debian.conf
 chmod +x /usr/local/bin/debian.conf
fi
./usr/local/bin/debian.conf
wget https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/S99chrootDebian.sh -o /usr/syno/etc/rc.d/S99chrootDebian.sh
chmod +x /usr/syno/etc/rc.d/S99chrootDebian.sh
wget https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/debian -o /usr/local/bin/debian
wget https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/start_debian -o /usr/local/bin/start_debian
wget https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/stop_debian -o /usr/local/bin/stop_debian
chmod +x /usr/local/bin/debian
chmod +x /usr/local/bin/start_debian
chmod +x /usr/local/bin/stop_debian

cp -p /etc/resolv.conf $DEBIAN_DIRECTORY/etc/resolv.conf
echo "127.0.0.1      localhost" > $DEBIAN_DIRECTORY/etc/hosts

fs=$(df $DEBIAN_DIRECTORY | grep -v 1K-blocks | cut -d\  -f1)
fstyp=$(grep "^$fs " /etc/mtab | cut -d\  -f3)
echo $fs / $fstyp > $DEBIAN_DIRECTORY/etc/mtab
echo $fs / $fstyp 0 0 > $DEBIAN_DIRECTORY/etc/fstab

echo "auto $DEBIAN_INTERFACE" > $DEBIAN_DIRECTORY/etc/network/interfaces
echo "iface $DEBIAN_INTERFACE inet static" >> $DEBIAN_DIRECTORY/etc/network/interfaces
echo "       address $DEBIAN_IP" >> $DEBIAN_DIRECTORY/etc/network/interfaces
echo "       netmask $DEBIAN_NETMASK" >> $DEBIAN_DIRECTORY/etc/network/interfaces
echo "       gateway $DEBIAN_GATEWAY" >> $DEBIAN_DIRECTORY/etc/network/interfaces


exit 0
