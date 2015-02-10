CHROOT=/volume1/synodebian
mount -o bind /dev $CHROOT/dev
mount -o bind /proc $CHROOT/proc
mount -o bind /dev/pts $CHROOT/dev/pts
mount -o bind /sys $CHROOT/sys
cp /etc/resolv.conf $CHROOT/etc/resolv.conf
cp /etc/hosts $CHROOT/etc/hosts
