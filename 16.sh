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
VX=$PWD/packages/apps/ViPER4AndroidFX
DBY=$PWD/hardware/dolby
OTA=$PWD/vendor/official_devices

rm -rf "$DT" "$CT" "VDT" "VCT" "HD" "KT" "DBY" "OTA"





clone_trees() {
#echo -e "${blue}Extras Cloning ${clear}"
#git clone git@github.com:AAMIRR-ALI/vendor_extras.git vendor/extras
echo -e "${blue}Device Tree Cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/device_realme_2076.git -b 16.2 device/realme/bladerunner
echo -e "${blue}Vendor Tree Cloning${clear}"
git clone https://github.com/AAMIRR-ALI/vendor_realme_2076.git vendor/realme/bladerunner -b 16.2
echo -e "${blue}Hardware cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/android_hardware_oplus.git hardware/oplus -b lineage-23.2
echo -e "${blue}Kernel cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/kernel_realme_bladerunner.git kernel/realme/sm8250 -b Entropy-1.0
echo -e "${blue}ViPER4AndroidFX cloning ${clear}"
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX
echo -e "${blue}Dolby cloning ${clear}"
git clone https://github.com/bijoyv9/hardware_dolby.git hardware/dolby
echo -e "${blue}AX-OTA cloning ${clear}"
git clone https://github.com/AAMIRR-ALI/OTA_AX.git vendor/official_devices
}

echo "Init yt? (1 = yes, anything else = no)"
read -r YT

if [ "$YT" = "1" ] || [ "$YT" = "y" ]; then
    git clone https://gitlab.com/AAMIRR-ALI/vendor-revanced.git vendor/revanced
    cd vendor/revanced || exit 1

    ./extract-libs.sh

    cd ../..
    
    cd frameworks/base
    git remote add yt https://github.com/PixelLineage/frameworks_base.git
    git fetch yt
    git cherry-pick 076076fed18f080ffd3ec2b51026f4164d87f1f6 1a7e975607fe3b70b49ca84726fb06ac216c62ef

    cd ../..
    
    
    clone_trees || exit 1	

else
	clone_trees
	
	cd frameworks/base
	git remote add yt https://github.com/PixelLineage/frameworks_base.git
	git fetch yt

	git cherry-pick 076076fed18f080ffd3ec2b51026f4164d87f1f6 1a7e975607fe3b70b49ca84726fb06ac216c62ef

	cd ../..
fi
