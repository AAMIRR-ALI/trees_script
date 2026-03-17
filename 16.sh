#!/bin/bash
red='\033[0;31m'                                                                          
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
clear='\033[0m'


# list of folders
DIRS=(
    "$PWD/device/realme"
    "$PWD/vendor/realme"
    "$PWD/hardware/oplus"
    "$PWD/kernel/realme/sm8250"
    "$PWD/packages/apps/ViPER4AndroidFX"
    "$PWD/hardware/dolby"
    "$PWD/vendor/official_devices"
)


for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Removing $dir"
        rm -rf "$dir"
    else
        echo "Skipping missing folder: $dir"
    fi
done


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

# Function to apply a commit safely
safe_cherry_pick() {
    for commit in "$@"; do
        # Check if commit is already in current branch
        if git cherry -v | grep -q "^+ $commit"; then
            echo "Applying commit $commit..."
            git cherry-pick "$commit" || {
                echo "Cherry-pick failed. Resolve conflicts manually."
                exit 1
            }
        else
            echo "Commit $commit already applied. Skipping."
        fi
    done
}

echo "Init yt? (1 = yes, anything else = no)"
read -r YT
echo "You entered: $YT"

COMMITS=("076076fed18f080ffd3ec2b51026f4164d87f1f6" "1a7e975607fe3b70b49ca84726fb06ac216c62ef")

if [ "$YT" = "1" ] || [ "$YT" = "y" ]; then
    clone_trees
    git clone https://gitlab.com/AAMIRR-ALI/vendor-revanced.git vendor/revanced
    cd vendor/revanced
    ./extract-libs.sh
    cd ../..
    
    cd frameworks/base
    git remote add yt https://github.com/PixelLineage/frameworks_base.git 2>/dev/null || \
    git remote set-url yt https://github.com/PixelLineage/frameworks_base.git

    safe_cherry_pick "${COMMITS[@]}"

    cd ../..
    
else
    echo "Skipping yt init..."
    cd frameworks/base
    git remote add yt https://github.com/PixelLineage/frameworks_base.git 2>/dev/null || \
    git remote set-url yt https://github.com/PixelLineage/frameworks_base.git
    git fetch yt

    safe_cherry_pick "${COMMITS[@]}"

    cd ../..
    
    clone_trees
fi
