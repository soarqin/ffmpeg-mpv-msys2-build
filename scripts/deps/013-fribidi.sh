if [ "x${FRIBIDI_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/fribidi/fribidi.git fribidi-${FRIBIDI_VERSION}
else
    download_file https://fribidi.org/download/fribidi-${FRIBIDI_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
pushd $SRC_ROOT/fribidi-${FRIBIDI_VERSION}
autoreconf -fi
popd
mkdir -p $BUILD_ROOT/fribidi-${FRIBIDI_VERSION}
pushd $BUILD_ROOT/fribidi-${FRIBIDI_VERSION}
mkdir -p gen.tab/unidata
cp -rf $SRC_ROOT/fribidi-${FRIBIDI_VERSION}/gen.tab/unidata/* gen.tab/unidata/
$SRC_ROOT/fribidi-${FRIBIDI_VERSION}/configure --prefix=${BUILD_INSTALL_ROOT} --enable-static --disable-shared --without-glib
make -j1
make install
popd
