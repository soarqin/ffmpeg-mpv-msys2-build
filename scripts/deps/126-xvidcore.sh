download_file http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.bz2 xvidcore
if [ "$result" = true ]; then return; fi
patch_source xvidcore 126-xvidcore.patch
mkdir -p $BUILD_ROOT/xvidcore
pushd $BUILD_ROOT/xvidcore
cp -Rf $SRC_ROOT/xvidcore/* .
pushd build/generic
./configure --prefix=$BUILD_INSTALL_ROOT --disable-pthread
make ${MAKE_JOBS}
make install
rm -f $BUILD_INSTALL_ROOT/bin/libxvidcore.dll $BUILD_INSTALL_ROOT/lib/libxvidcore.dll.a
popd
popd
