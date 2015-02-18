#!/bin/bash
debconf=/usr/local/bin/debian.conf

function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}

jumpto $start

start:

echo -n "Press <enter> to continue. "
read randomkey

until [ -n "$debiandir" ]; do
 echo -n "Please enter the directory where chrootdebian is extracted to [/volume1/synodebian]: "
 read debiandir
  case $debiandir in
  /)
   echo "Don't think its installed in root (/)?"
   unset debiandir
   continue
  ;;
  /*|"")
   [ -z "$debiandir" ] && debiandir="/volume1/synodebian"
   continue
  ;;
  *)
   echo "The private directory must start with a \"/\".  Try again."
   echo ""
   unset debiandir
   continue
  ;;
 esac
done

until [ -n "$debianif" ]; do
 echo -n "Interface chroot debian should use [eth0:0]: "
 read debianif
  case $debianif in
  eth*:*|"")
   [ -z "$debianif" ] && debianif="eth0:0"
   continue
  ;;
  *)
   echo "must be a interface like eth0:0"
   unset debianif
   continue
  ;;
 esac
done

until [ -n "$debianip" ]; do
 echo -n "IP chroot debian should use [192.168.1.222]: "
 read debianip
  case $debianip in
  *.*.*.*|"")
   [ -z "$debianip" ] && debianip="192.168.1.222"
   continue
  ;;
  *)
   echo "must be a ip4 address like 192.168.1.222"
   unset debianip
   continue
  ;;
 esac
done

until [ -n "$debianipmask" ]; do
 echo -n "netmask chroot debian should use [255.255.255.0]: "
 read debianipmask
  case $debianipmask in
  *.*.*.*|"")
   [ -z "$debianipmask" ] && debianipmask="255.255.255.0"
   continue
  ;;
  *)
   echo "must be a ip4 netmask address like 255.255.255.0"
   unset debianipmask
   continue
  ;;
 esac
done

until [ -n "$debianipgw" ]; do
 echo -n "gateway chroot debian should use [192.168.1.1]: "
 read debianipgw
  case $debianipgw in
  *.*.*.*|"")
   [ -z "$debianipgw" ] && debianipgw="192.168.1.1"
   continue
  ;;
  *)
   echo "must be a ip4 gateway address like 192.168.1.1"
   unset debianipgw
   continue
  ;;
 esac
done

until [ -n "$fine" ]; do
    echo -e "\n\nPlease check that everything is ok\n"
    echo -e "chroot debian=$debiandir"
    echo -e "interface=$debianif"
    echo -e "debian chroot ip=$debianip"
    echo -e "debian chroot netmask=$debianipmask"
    echo -e "debian chroot gateway=$debianipgw\n"
    echo -n "Everything file? [Y]es [N]o: "
    read fine
    case $fine in
        [Nn])
            echo "re-enter the settings"
	    unset debiandir
	    unset debianip
	    unset debianif
	    unset debianipmask
	    unset debianipgw
            unset fine
	    jumpto $start
        ;;
        [Yy])

            echo "DEBIAN_DIRECTORY=$debiandir" > $debconf
            echo "DEBIAN_INTERFACE=$debianif" >> $debconf
            echo "DEBIAN_IP=$debianip" >> $debconf
            echo "DEBIAN_NETMASK=$debianipmask" >> $debconf
            echo "DEBIAN_GATEWAY=$debianipgw" >> $debconf
	    chmod +x $debconf
            fine="y"
        ;;
        *)
            unset fine
            continue
        ;;
    esac
done

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
