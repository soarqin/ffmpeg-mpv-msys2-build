BZIP_VERSION=1.0.6
download_file http://www.bzip.org/1.0.6/bzip2-${BZIP_VERSION}.tar.gz
if [ $result == true ]; then return; fi
cd $BUILD_ROOT && rm -rf bzip2
cp -Rf $SRC_ROOT/bzip2-${BZIP_VERSION} ./bzip2 && cd bzip2
sed -i -e "/PREFIX=/d" Makefile
make PREFIX=$BUILD_INSTALL_ROOT $JOBS install
