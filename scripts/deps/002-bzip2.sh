download_file http://www.bzip.org/1.0.6/bzip2-${BZIP_VERSION}.tar.gz
if [ "$result" = true ]; then return; fi
patch_source bzip2-${BZIP_VERSION} 002-bzip2.patch
pushd $BUILD_ROOT
rm -rf bzip2
cp -Rf $SRC_ROOT/bzip2-${BZIP_VERSION} ./bzip2
pushd bzip2
make CHOST=${BUILD_CHOST}- PREFIX=$BUILD_INSTALL_ROOT ${MAKE_JOBS} install
popd
popd
