# chroot-debian-synology-ds410

You will need a Synology DS410 and a Debian server to do this trick.

We only use the debian server shortly

start with


    apt-get install debootstrap
    mkdir synodebian
    debootstrap .foreign .arch powerpc wheezy synodebian

