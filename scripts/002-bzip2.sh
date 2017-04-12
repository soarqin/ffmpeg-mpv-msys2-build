download_file http://www.bzip.org/1.0.6/bzip2-${BZIP_VERSION}.tar.gz
if [ $result == true ]; then return; fi
pushd $BUILD_ROOT
rm -rf bzip2
cp -Rf $SRC_ROOT/bzip2-${BZIP_VERSION} ./bzip2
pushd bzip2
sed -i -e "/PREFIX=/d" Makefile
make PREFIX=$BUILD_INSTALL_ROOT $JOBS install
popd
popd
