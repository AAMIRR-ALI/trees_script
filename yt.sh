#!/bin/bash


COMMITS=("076076fed18f080ffd3ec2b51026f4164d87f1f6" "1a7e975607fe3b70b49ca84726fb06ac216c62ef")

    clone_trees
    git clone https://gitlab.com/AAMIRR-ALI/vendor-revanced.git vendor/revanced
    cd vendor/revanced
    ./extract-libs.sh
    cd ../..
    
    cd frameworks/base
    git remote add yt https://github.com/PixelLineage/frameworks_base.git 2>/dev/null || \
    git remote yt https://github.com/PixelLineage/frameworks_base.git
    git cherry-pick "076076fed18f080ffd3ec2b51026f4164d87f1f6" "1a7e975607fe3b70b49ca84726fb06ac216c62ef"

    cd ../..
