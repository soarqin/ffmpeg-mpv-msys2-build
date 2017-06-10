src_root=libmysofa-${LIBMYSOFA_VERSION}
if [ "x${LIBMYSOFA_VERSION}" == "xgit" ]; then
    git_clone https://github.com/hoene/libmysofa $src_root
else
    src_root=libmysofa-${LIBMYSOFA_VERSION/,/-}
    download_file https://github.com/hoene/libmysofa/archive/v${LIBMYSOFA_VERSION}.tar.gz $src_root
fi
if [ $result == true ]; then return; fi
compile_with_cmake $src_root -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF
