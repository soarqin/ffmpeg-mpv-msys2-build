if [ "x${KVAZAAR_VERSION}" == "xgit" ]; then
    git_clone https://github.com/ultravideo/kvazaar kvazaar-${KVAZAAR_VERSION}
else
    download_file https://github.com/ultravideo/kvazaar/releases/download/v${KVAZAAR_VERSION}/kvazaar-v${KVAZAAR_VERSION}.tar.gz kvazaar-${KVAZAAR_VERSION}
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/kvazaar-${KVAZAAR_VERSION}
sed -i -e 's,defined(KVZ_STATIC_LIB),1,g' src/kvazaar.h
sed -i -e 's/\[CFLAGS="-Werror $CFLAGS"\], \[\]/\[\], \[CFLAGS="-Werror $CFLAGS"\]/g' configure.ac
popd
compile_with_configure kvazaar-${KVAZAAR_VERSION} --enable-static --disable-shared --disable-werror
