download_file http://zlib.net/zlib-1.2.11.tar.xz
cd $BUILD_ROOT && rm -rf zlib
cp -Rf $SRC_ROOT/zlib-1.2.11 ./zlib && cd zlib
make BINARY_PATH=$BUILD_INSTALL_ROOT/bin INCLUDE_PATH=$BUILD_INSTALL_ROOT/include LIBRARY_PATH=$BUILD_INSTALL_ROOT/lib -f win32/Makefile.gcc $JOBS install
