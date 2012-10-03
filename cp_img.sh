#!/bin/sh

ANDROID_PATH=`pwd`
TAGET_PRODUCT=beagleboard
FILE_IMAGE_PATH=$ANDROID_PATH/out/target/product/$TAGET_PRODUCT
KERNEL_IMAGE_PATH=$ANDROID_PATH/kernel/arch/arm/boot
UBOOT_IMAGE_PATH=$ANDROID_PATH/u-boot
XLOADER_IMAGE_PATH=$ANDROID_PATH/x-loader
TAR_TOOL=$ANDROID_PATH/build/tools
BOOT_TOOL=$ANDROID_PATH/../tools/mk-bootscr

############# Copy all the system image and rootfs  ##############

echo "Check folder whether exist.."
if [ ! -d $ANDROID_PATH/prebuilt_images ]; then
    mkdir $ANDROID_PATH/prebuilt_images
fi

if [ ! -d $ANDROID_PATH/prebuilt_images/Boot_Images ]; then
    mkdir $ANDROID_PATH/prebuilt_images/Boot_Images
fi

if [ ! -d $ANDROID_PATH/prebuilt_images/Filesystem ]; then
    mkdir $ANDROID_PATH/prebuilt_images/Filesystem
fi

echo "Copy all the image start !"

echo "Copy kernel uImage ..."
if [ ! -f $KERNEL_IMAGE_PATH/uImage ]; then
    echo "Not such kernel image !"
    exit 1
else
    cp $KERNEL_IMAGE_PATH/uImage $ANDROID_PATH/prebuilt_images/Boot_Images
fi

echo "Copy uboot image ..."
if [ ! -f $UBOOT_IMAGE_PATH/u-boot.bin ]; then
    echo "Not such u-boot image !"
    exit 1
else
    cp $UBOOT_IMAGE_PATH/u-boot.bin $ANDROID_PATH/prebuilt_images/Boot_Images
fi

echo "Copy x-loader image..."
if [ ! -f $XLOADER_IMAGE_PATH/MLO ]; then
    echo "Not such x-loader image !"
    exit 1
else
    cp $XLOADER_IMAGE_PATH/MLO $ANDROID_PATH/prebuilt_images/Boot_Images
fi

echo "Coopy boot command scr..."
if [ ! -f $BOOT_TOOL/boot.scr ]; then
    echo "Not such boot load script !"
    exit 1
else
    cp $BOOT_TOOL/boot.scr $ANDROID_PATH/prebuilt_images/Boot_Images
fi

echo "Copy ROOTFS ..."
if [ ! -d $FILE_IMAGE_PATH ]; then
    echo "Not such "$FILE_IMAGE_PATH" ! "
    exit 1
fi

if [ ! -d $FILE_IMAGE_PATH/android_rootfs ]; then
    mkdir $FILE_IMAGE_PATH/android_rootfs
fi

cp -r $FILE_IMAGE_PATH/root/* $FILE_IMAGE_PATH/android_rootfs && cp -r $FILE_IMAGE_PATH/system $FILE_IMAGE_PATH/android_rootfs
cd $FILE_IMAGE_PATH
sudo $TAR_TOOL/mktarball.sh $ANDROID_PATH/out/host/linux-x86/bin/fs_get_stats android_rootfs . rootfs rootfs.tar.bz2
cp $FILE_IMAGE_PATH/rootfs.tar.bz2 $ANDROID_PATH/prebuilt_images/Filesystem

cp $BOOT_TOOL/../mk-mmc/mkmmc-android.sh $ANDROID_PATH/prebuilt_images

echo "Copy all the image finish !!"
