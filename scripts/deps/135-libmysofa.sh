src_root=libmysofa-${LIBMYSOFA_VERSION}
if [ "x${LIBMYSOFA_VERSION}" == "xgit" ]; then
    git_clone https://github.com/hoene/libmysofa $src_root
else
    download_file https://github.com/hoene/libmysofa/archive/v${LIBMYSOFA_VERSION}.tar.gz libmysofa-${LIBMYSOFA_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_cmake_dirty libmysofa-${LIBMYSOFA_VERSION} -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF
