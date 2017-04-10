XVID_VERSION=1.3.4
download_file http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.bz2 xvidcore
if [ $result == true ]; then return; fi
cd $BUILD_ROOT && mkdir -p xvidcore && cd xvidcore
cp -Rf $SRC_ROOT/xvidcore/* .
cd build/generic
sed -i -e 's,_LIB="xvidcore,_LIB="libxvidcore,g' configure
./configure --prefix=$BUILD_INSTALL_ROOT --disable-pthread
make $JOBS
make install
rm -f $BUILD_INSTALL_ROOT/bin/libxvidcore.dll $BUILD_INSTALL_ROOT/lib/libxvidcore.dll.a
