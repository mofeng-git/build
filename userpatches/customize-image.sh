#!/bin/bash

# arguments: $RELEASE $LINUXFAMILY $BOARD $BUILD_DESKTOP
#
# This is the image customization script

# NOTE: It is copied to /tmp directory inside the image
# and executed there inside chroot environment
# so don't reference any files that are not already installed

# NOTE: If you want to transfer files between chroot and host
# userpatches/overlay directory on host is bind-mounted to /tmp/overlay in chroot
# The sd card's root path is accessible via $SDCARD variable.

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

Main() {
	case $RELEASE in
		bookworm)
			# your code here
			cp /tmp/overlay/led/* /usr/bin/
			cp -f /tmp/overlay/meson8b-onecloud.dtb /boot/dtb/meson8b-onecloud.dtb
    	cat <<EOF >/etc/rc.local
#!/bin/bash
green_on
exit 0
EOF
      chmod +x /etc/rc.local
      systemctl enable rc-local.service
			;;
    jammy)
			cp /tmp/overlay/led/* /usr/bin/
			cp -f /tmp/overlay/meson8b-onecloud.dtb /boot/dtb/meson8b-onecloud.dtb && echo "meson8b-onecloud.dtb file copied!"
    	cat <<EOF >/etc/rc.local
#!/bin/bash
green_on
exit 0
EOF
      chmod +x /etc/rc.local
      systemctl enable rc-local.service
		  #cd /tmp/overlay/One-KVM
      #bash install.sh
			;;
	esac
} # Main

Main "$@"
