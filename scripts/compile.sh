function compile_with_configure {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    if [ ! -f $SRC_ROOT/$src_dir/configure ]; then
        pushd $SRC_ROOT/$src_dir && autoreconf -fi && popd
    fi
    rm -rf $BUILD_ROOT/$dst_dir && mkdir -p $BUILD_ROOT/$dst_dir 
    pushd $BUILD_ROOT/$dst_dir
    `realpath -m --relative-to=. $SRC_ROOT`/$src_dir/configure --prefix="$BUILD_INSTALL_ROOT" $*
    make ${MAKE_JOBS} || make ${MAKE_JOBS}
    make install
    popd
}

function compile_with_configure_dirty {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    rm -rf $BUILD_ROOT/$dst_dir && mkdir -p $BUILD_ROOT/$dst_dir 
    pushd $BUILD_ROOT/$dst_dir
    cp -Rf $SRC_ROOT/$src_dir/* .
    cp -Rf $SRC_ROOT/$src_dir/.svn . 1>/dev/null 2>&1 || true
    if [ ! -f ./configure ]; then
        autoreconf -fi
    fi
    ./configure --prefix=$BUILD_INSTALL_ROOT $*
    make ${MAKE_JOBS}
    make install
    popd
}

function compile_with_cmake {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    rm -rf $BUILD_ROOT/$dst_dir && mkdir -p $BUILD_ROOT/$dst_dir
    pushd $BUILD_ROOT/$dst_dir
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_ROOT" $* $SRC_ROOT/$src_dir
    make ${MAKE_JOBS}
    make install
    popd
}

function compile_with_cmake_dirty {
    local src_dir=$1
    local dst_dir=${1##*/}
    shift
    rm -rf $BUILD_ROOT/$dst_dir && cp -Rf $SRC_ROOT/$src_dir $BUILD_ROOT/$dst_dir
    pushd $BUILD_ROOT/$dst_dir
    mkdir -p build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_ROOT" $* ..
    make ${MAKE_JOBS}
    make install
    popd
}
