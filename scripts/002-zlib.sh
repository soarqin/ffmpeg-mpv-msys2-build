download_file http://zlib.net/zlib-1.2.11.tar.xz
cd $SRC_ROOT/zlib-1.2.11
echo $BUILD_INSTALL_ROOT
make BINARY_PATH=$BUILD_INSTALL_ROOT/bin INCLUDE_PATH=$BUILD_INSTALL_ROOT/include LIBRARY_PATH=$BUILD_INSTALL_ROOT/lib -f win32/Makefile.gcc $JOBS install
