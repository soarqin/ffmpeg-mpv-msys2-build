if [ "x${SNAPPY_VERSION}" == "xgit" ]; then
    git_clone https://github.com/google/snappy snappy-${SNAPPY_VERSION}
else
    download_file https://github.com/google/snappy/archive/${SNAPPY_VERSION}.tar.gz snappy-${SNAPPY_VERSION}
fi
if [ "$result" = true ]; then return; fi
patch_source snappy-${SNAPPY_VERSION} 004-snappy.patch
auto_reconf snappy-${SNAPPY_VERSION}
pushd $SRC_ROOT/snappy-${SNAPPY_VERSION}
if [ ! -f ./README ]; then
    touch ./README
fi
popd
compile_with_configure snappy-${SNAPPY_VERSION} --enable-static --disable-shared
