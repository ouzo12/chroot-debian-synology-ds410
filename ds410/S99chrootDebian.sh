DEBIAN_DIRECTORY=/volume1/synodebian
mount -o bind /dev $DEBIAN_DIRECTORY/dev
mount -o bind /proc $DEBIAN_DIRECTORY/proc
mount -o bind /dev/pts $DEBIAN_DIRECTORY/dev/pts
mount -o bind /sys $DEBIAN_DIRECTORY/sys
cp /etc/resolv.conf $DEBIAN_DIRECTORY/etc/resolv.conf
cp /etc/hosts $DEBIAN_DIRECTORY/etc/hosts
