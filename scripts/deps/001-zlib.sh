download_file http://zlib.net/zlib-${ZLIB_VERSION}.tar.xz
if [ $result == true ]; then return; fi
pushd $BUILD_ROOT
rm -rf zlib
cp -Rf $SRC_ROOT/zlib-${ZLIB_VERSION} ./zlib
pushd zlib
make BINARY_PATH=$BUILD_INSTALL_ROOT/bin INCLUDE_PATH=$BUILD_INSTALL_ROOT/include LIBRARY_PATH=$BUILD_INSTALL_ROOT/lib -f win32/Makefile.gcc ${MAKE_JOBS} install
popd
popd
