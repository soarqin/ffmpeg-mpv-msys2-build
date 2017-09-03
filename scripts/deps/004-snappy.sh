if [ "x${SNAPPY_VERSION}" == "xgit" ]; then
    git_clone https://github.com/google/snappy snappy-${SNAPPY_VERSION}
else
    download_file https://github.com/google/snappy/archive/${SNAPPY_VERSION}.tar.gz snappy-${SNAPPY_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_cmake snappy-${SNAPPY_VERSION} -DBUILD_SHARED_LIBS=OFF -DSNAPPY_BUILD_TESTS=OFF
