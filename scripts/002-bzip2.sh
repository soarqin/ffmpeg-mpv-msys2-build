download_file http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
cd $BUILD_ROOT && rm -rf bzip2
cp -Rf $SRC_ROOT/bzip2-1.0.6 ./bzip2 && cd bzip2
sed -i -e "/PREFIX=/d" Makefile
make PREFIX=$BUILD_INSTALL_ROOT $JOBS install
