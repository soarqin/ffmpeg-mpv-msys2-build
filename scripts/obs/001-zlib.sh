download_file http://zlib.net/zlib-${ZLIB_VERSION}.tar.xz
if [ "$result" = true ]; then return; fi
patch_source zlib-${ZLIB_VERSION} 001-zlib.patch
pushd $BUILD_ROOT
rm -rf zlib
cp -Rf $SRC_ROOT/zlib-${ZLIB_VERSION} ./zlib
pushd zlib
CHOST=${MINGW_CHOST} ./configure --prefix=${BUILD_INSTALL_ROOT} --shared
make
make install
popd
popd
