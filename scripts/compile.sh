function compile_with_configure {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    if [ ! -f $SRC_ROOT/$src_dir/configure ]; then
        cd $SRC_ROOT/$src_dir && autoreconf -ifv
    fi
    cd $BUILD_ROOT && mkdir -p $dst_dir && cd $dst_dir && `realpath --relative-to=. $SRC_ROOT`/$src_dir/configure --prefix="$BUILD_INSTALL_ROOT" $* && make $JOBS && make install
}

function compile_with_configure_dirty {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    cd $BUILD_ROOT && mkdir -p $dst_dir && cd $dst_dir && cp -Rf $SRC_ROOT/$src_dir/* .
    cp -Rf $SRC_ROOT/$src_dir/.svn . || true
    if [ ! -f ./configure ]; then
        autoreconf -ifv
    fi
    ./configure --prefix=$BUILD_INSTALL_ROOT $* && make $JOBS && make install
}

function compile_with_cmake {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    cd $BUILD_ROOT && mkdir -p $dst_dir && cd $dst_dir
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_ROOT" $* $SRC_ROOT/$src_dir
    make $JOBS && make install
}
