#!/bin/bash
echo "*** preparing GTA04 rootfs ***"
cd out/target/product/gta04/ || exit 1
mkdir -p rootfs/boot

echo "*** copying system ***"
cp -a system rootfs/

echo "*** copying root ***"
cp -a root/* rootfs/

echo "*** copying recovery ***"
cp -a recovery rootfs/

echo "*** copying kernel ***"
cp kernel rootfs/boot/uImage
(
cd rootfs/sbin/ &&
ln -s ../init init
)

#FIXME: this should be properly patched in the build system
#       have a look at vendor/replicant/config/common.mk
echo "*** fixing file permissions ***"
chmod 644 rootfs/init*.rc
chmod 644 rootfs/ueventd*.rc
chmod 644 rootfs/*.prop
chmod 644 rootfs/system/lib/modules/*.ko
chmod 644 rootfs/system/*.prop
chmod 775 rootfs/system/bin/sysinit
chmod 775 rootfs/system/bin/handle_compcache

echo "*** generating GTA04 rootfs ***"
cd rootfs/ &&
tar cjvf ../gta04-rootfs.tar.bz2 .

echo "*** cleaning up GTA04 rootfs ***"
rm -rf rootfs/
echo "Result is here:"
echo "out/target/product/gta04/gta04-rootfs.tar.bz2"
