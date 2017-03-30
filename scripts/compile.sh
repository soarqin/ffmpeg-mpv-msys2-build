function compile_with_configure {
    local src_dir=$1
    shift
    if [ ! -f $SRC_ROOT/$src_dir/configure ]; then
        cd $SRC_ROOT/$src_dir && autoreconf -ifv || exit 1
    fi
    cd $BUILD_ROOT && mkdir -p $src_dir && cd $src_dir && `realpath --relative-to=. $SRC_ROOT`/$src_dir/configure --prefix=$BUILD_INSTALL_ROOT $* && make $JOBS install || exit 1
}

function compile_with_configure_dirty {
    local src_dir=$1
    shift
    cd $BUILD_ROOT && mkdir -p $src_dir && cd $src_dir && cp -Rf $SRC_ROOT/$src_dir/* . || exit 1
    if [ ! -f ./configure ]; then
        autoreconf -ifv || exit 1
    fi
    ./configure --prefix=$BUILD_INSTALL_ROOT $* && make $JOBS install || exit 1
}
