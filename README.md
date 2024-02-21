### 构建示例

```bash
apt-get -y install git
git clone --depth=1 --branch=main https://github.com/armbian/build
cd build
./compile.sh build BOARD=onecloud BRANCH=edge BUILD_DESKTOP=no BUILD_MINIMAL=yes COMPRESS_OUTPUTIMAGE=img EXTRAWIFI=yes  KERNEL_CONFIGURE=no  DOWNLOAD_MIRROR=china MAINLINE_MIRROR=tuna RELEASE=jammy INCLUDE_HOME_DIR=yes
./userpatches/burnimg-pack.sh output/images/Armbian-xdarklight_by-SilentWind_24.5.0-trunk_Onecloud_jammy_edge_6.7.0-rc6_minimal.img
```
