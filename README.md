# chroot-debian-synology-ds410

You will need a Synology DS410 and a Debian server to do this trick.
The Synology also needs to be bootstrapped.

First bootstrap the DS410
telnet or ssh to the synology as root

    wget http://ipkg.nslu2-linux.org/feeds/optware/syno-e500/cross/unstable/syno-e500-bootstrap_1.2-7_powerpc.xsh
    sh ./syno-e500-bootstrap_1.2-7_powerpc.xsh
    ipkg update

install some nesassary tools

    ipkg install bash less vim man file findutils grep coreutils tar gzip bzip2 xz-utils
    ipkg remove wget
    ipkg install wget-ssl
    ipkg install optware-devel

DS410 is now ready.

Lets go to the debian server.
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

    wget --no-check-certificate -o /root/deb-setup.sh https://raw.githubusercontent.com/ouzo12/chroot-debian-synology-ds410/master/ds410/setup.sh 
    chmod +x /root/deb-setup.sh
    ./root/deb-setup.sh


