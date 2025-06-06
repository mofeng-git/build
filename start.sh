 #!/bin/bash

RELEASE=bookworm

 ./compile.sh build BOARD=onecloud BRANCH=legacy BUILD_DESKTOP=no BUILD_MINIMAL=yes OFFLINE_WORK=yes \
    COMPRESS_OUTPUTIMAGE=img EXTRAWIFI=yes  KERNEL_CONFIGURE=no  DOWNLOAD_MIRROR=china MAINLINE_MIRROR=tuna \
    RELEASE=${RELEASE} BOOTSIZE=64  SYNC_CLOCK=no INCLUDE_HOME_DIR=yes USE_CCACHE=yes ALLOW_ROOT=yes PESTER_TERMINAL=no \
    KERNEL_COMPILER=/opt/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-

./userpatches/burnimg-pack.sh output/images/Armbian_by-SilentWind_24.5.0-trunk_Onecloud_${RELEASE}_legacy_5.9.0-rc7_minimal.img

