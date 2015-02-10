# chroot-debian-synology-ds410

You will need a Synology DS410 and a Debian server to do this trick.

We only use the debian server shortly

start with


    apt-get install debootstrap
    mkdir synodebian
    debootstrap --foreign --arch powerpc wheezy synodebian

Now the data should be send to the synology nas


    tar cvzpf synodebian.tar.gz synodebian
    scp synodebian.tar.gz root@minsynologyds410nas:/volume1/

Thats it, you dont have to use the debian server any more. The rest is on the synology nas

At the nas extract the tar file


    cd /volume1/
    tar xvzpf synodebian.tar.gz

