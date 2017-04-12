if [ "x${FRIBIDI_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/fribidi/fribidi.git fribidi-${FRIBIDI_VERSION}
else
    download_file https://fribidi.org/download/fribidi-${FRIBIDI_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
mkdir -p $BUILD_ROOT/fribidi-${FRIBIDI_VERSION}
pushd $BUILD_ROOT/fribidi-${FRIBIDI_VERSION}
mkdir -p gen.tab/unidata
cp -rf $SRC_ROOT/fribidi-${FRIBIDI_VERSION}/gen.tab/unidata/* gen.tab/unidata/
JOBS_OLD=$JOBS
JOBS=-j1
popd
compile_with_configure fribidi-${FRIBIDI_VERSION} --enable-static --disable-shared --without-glib
JOBS=$JOBS_OLD
