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

echo "*** generating GTA04 rootfs ***"
cd rootfs/ &&
tar cjvf ../gta04-rootfs.tar.bz2 .

echo "*** cleaning up GTA04 rootfs ***"
rm -rf rootfs/
echo "Result is here:"
echo "out/target/product/gta04/gta04-rootfs.tar.bz2"
