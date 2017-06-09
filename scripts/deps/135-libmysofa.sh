src_root=libmysofa-${LIBMYSOFA_VERSION}
if [ "x${LIBMYSOFA_VERSION}" == "xgit" ]; then
    git_clone https://github.com/hoene/libmysofa $src_root
else
    src_root=libmysofa-${LIBMYSOFA_VERSION/,/-}
    download_file https://github.com/hoene/libmysofa/archive/v${LIBMYSOFA_VERSION}.tar.gz $src_root
fi
if [ $result == true ]; then return; fi
mkdir -p $BUILD_ROOT/$src_root
pushd $BUILD_ROOT/$src_root
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$BUILD_INSTALL_ROOT -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF $SRC_ROOT/$src_root
make ${MAKE_JOBS}
make install
popd
