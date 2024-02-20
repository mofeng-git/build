#!/bin/bash
#��Ҫ���Σ�����Ϊ��Ҫת���ľ���·��
CURRENTWD=$PWD
IMGFILE=$1
length=${#IMGFILE}
diskimg=$(echo ${IMGFILE::length-4})
loop=$(losetup -f)
#��������ļ��Ƿ����
sudo apt install img2simg

if [ ! -f $IMGFILE ];then
  echo "No such file:$IMGFILE !"
  exit
fi

if [ ! -d "output/amlimg" ];then
  sudo mkdir output/amlimg
fi


if [ ! -d "/tmp/amlimg" ];then
  mkdir /tmp/amlimg
fi


if [ ! -f "output/amlimg/AmlImg" ];then
  sudo curl -L -o output/amlimg/AmlImg https://github.com/hzyitc/AmlImg/releases/download/v0.3.1/AmlImg_v0.3.1_linux_amd64
  sudo chmod +x output/amlimg/AmlImg
fi

if [ ! -f "output/amlimg/eMMC.burn.img" ];then
  sudo curl -L -o output/amlimg/eMMC.burn.img https://github.com/hzyitc/u-boot-onecloud/releases/download/build-20221028-0940/eMMC.burn.img
fi

#���ת��Ϊ��ˢ�������ʽ
sudo ./output/amlimg/AmlImg unpack output/amlimg/eMMC.burn.img output/amlimg
sudo losetup  --show --partscan $loop $IMGFILE
sudo img2simg ${loop}p1 output/amlimg/boot.simg
sudo img2simg ${loop}p2 output/amlimg/rootfs.simg
sudo losetup -d $loop
#sudo chown $(id -u):$(id -g) -R output/amlimg/

#д��ˢ���ļ���ȥ������У��
cat <<EOF >output/amlimg/commands.txt
USB:DDR:normal:0.DDR.USB
USB:UBOOT_COMP:normal:1.UBOOT_COMP.USB
ini:aml_sdc_burn:normal:2.aml_sdc_burn.ini
conf:platform:normal:3.platform.conf
PARTITION:bootloader:normal:4.bootloader.PARTITION
PARTITION:resource:normal:6.resource.PARTITION
PARTITION:boot:sparse:boot.simg
PARTITION:rootfs:sparse:rootfs.simg
EOF
sudo rm ./output/amlimg/5.bootloader.VERIFY ./output/amlimg/7.resource.VERIFY

#���Ϊ��ˢ����
burnimg=$diskimg.burn.img
sudo ./output/amlimg/AmlImg pack $burnimg output/amlimg/
echo "complete! File:$burnimg"

#���Ϊ��ˢ��������

sdimg=$diskimg.sdupdate.zip

#sudo cp output/amlimg/boot.simg /mnt && sudo cp output/amlimg/rootfs.simg /mnt
cp -f userpatches/ReadMe.txt output/amlimg/
sudo mkimage -C none -A arm -T script -d userpatches/sdburning.ini output/amlimg/boot.scr 
cd output/amlimg && sudo zip ../../$sdimg boot.scr  boot.simg rootfs.simg ReadMe.txt
echo "complete! File:$sdimg"
sudo rm -r /tmp/amlimg
#pixz -9 <$burnimg >${burnimg}.xz
