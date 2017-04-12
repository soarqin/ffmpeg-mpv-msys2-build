if [ "x${SNAPPY_VERSION}" == "xgit" ]; then
    git_clone https://github.com/google/snappy snappy-${SNAPPY_VERSION}
else
    download_file https://github.com/google/snappy/releases/download/${SNAPPY_VERSION}/snappy-${SNAPPY_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/snappy-${SNAPPY_VERSION}
if [ ! -f ./README ]; then
    touch ./README
fi
popd
compile_with_configure snappy-${SNAPPY_VERSION} --enable-static --disable-shared
