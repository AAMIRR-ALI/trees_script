#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
clear='\033[0m'
DT=$PWD/device/realme/bladerunner
CT=$PWD/device/realme/sm8250-common
VDT=$PWD/vendor/realme/bladerunner
VCT=$PWD/vendor/realme/sm8250-common
HD=$PWD/hardware/oplus
KT=$PWD/kernel/realme/sm8250

clone_trees() {
echo -e "${blue}Device Tree Cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/android_device_realme_bladerunner.git -b vic device/realme/bladerunner
git clone git@github.com:AAMIRR-ALI/android_device_realme_sm8250-common.git -b vic device/realme/sm8250-common

echo -e "${blue}Vendor Tree Cloning${clear}"
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b udc vendor/realme/bladerunner
git clone git@github.com:Matrixx-Devices/vendor_realme_sm8250-common.git -b vic vendor/realme/sm8250-common
vendor/realme/sm8250-common

echo -e "${blue}Kernel cloning ${clear}"
git clone git@github.com:Matrixx-Devices/kernel_realme_sm8250.git kernel/realme/sm8250 --depth=1

echo -e "${blue}Hardware cloning ${clear}"
git clone git@github.com:Matrixx-Devices/hardware_oplus.git hardware/oplus -b cr

echo -e "${blue}Dolby cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/hardware_dolby.git hardware/dolby

echo -e "${blue}ViperX cloning ${clear}"
git clone https://github.com/Chaitanyakm/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX

echo -e "${blue}VancedManager cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/VancedManager.git packages/apps/VancedManager

echo -e "${blue}BCR cloning ${clear}"
git clone https://github.com/Chaitanyakm/vendor_bcr.git vendor/bcr
}

if [ -d $DT ] && [ -d $CT ] && [ -d $VDT ] && [ -d $VCT ] && [ -d $KT ] && [ -d $HD ] ; then
    echo -e "${blue}Trees exists, Skipping !${clear}"
else
    clone_trees
fi

. build/envsetup.sh

lunch aosp_bladerunner-ap3a-userdebug && export CCACHE_EXEC=$(which ccache) && export USE_CCACHE=1 && export CCACHE_DIR=/home/ali/.ccache/ && ccache -M 1000G && m installclean && mka bacon
