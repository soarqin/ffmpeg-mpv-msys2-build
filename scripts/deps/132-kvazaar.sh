if [ "x${KVAZAAR_VERSION}" == "xgit" ]; then
    git_clone https://github.com/ultravideo/kvazaar kvazaar-${KVAZAAR_VERSION}
else
    download_file https://github.com/ultravideo/kvazaar/releases/download/v${KVAZAAR_VERSION}/kvazaar-v${KVAZAAR_VERSION}.tar.gz kvazaar-${KVAZAAR_VERSION}
fi
if [ $result == true ]; then return; fi
patch_source kvazaar-${KVAZAAR_VERSION} 132-kvazaar.patch 1
compile_with_configure kvazaar-${KVAZAAR_VERSION} --enable-static --disable-shared --disable-werror
