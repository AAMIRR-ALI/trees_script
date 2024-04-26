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
echo -e "${blue}dt cloning ${clear}"
git clone git@github.com:Matrixx-Devices/device_realme_bladerunner.git -b wip device/realme/bladerunner
git clone git@github.com:Matrixx-Devices/device_realme_sm8250-common.git -b big device/realme/sm8250-common

echo -e "${blue}vt cloning${clear}"
git clone https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git -b wip vendor/realme/bladerunner
git clone git@github.com:Matrixx-Devices/vendor_realme_sm8250-common.git -b wip vendor/realme/sm8250-common

echo -e "${blue}kt cloning ${clear}"
git clone git@github.com:AAMIRR-ALI/bigshot_kernel_realme_sm8250.git kernel/realme/sm8250

echo -e "${blue}HD cloning ${clear}"
git clone git@github.com:Matrixx-Devices/hardware_oplus.git hardware/oplus

echo -e "${blue}bcr cloning ${clear}"
git clone -b main https://github.com/Chaitanyakm/vendor_bcr.git vendor/bcr
}

if [ -d $DT ] && [ -d $CT ] && [ -d $VDT ] && [ -d $VCT ] && [ -d $KT ] && [ -d $HD ] ; then
    echo -e "${blue}Trees exists, Skipping !${clear}"
else
    clone_trees
fi

echo -e "${blue}FW cloning ${clear}"
clone_fw

. build/envsetup.sh

lunch lineage_bladerunner-ap1a-userdebug && m installclean && m bacon
