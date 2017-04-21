export ACLOCAL_PATH="$BUILD_INSTALL_ROOT/share/aclocal:$ACLOCAL_PATH"
export MANPATH="$BUILD_INSTALL_ROOT/share/man:$MANPATH"
export PATH="$BUILD_INSTALL_ROOT/bin:$PATH"
export PKG_CONFIG_PATH="$BUILD_INSTALL_ROOT/lib/pkgconfig:$PKG_CONFIG_PATH"
export CPATH="$BUILD_INSTALL_ROOT/include"
export LIBRARY_PATH="$BUILD_INSTALL_ROOT/lib"
if [ "x${MAKE_JOBS}" == "x" ]; then
    MAKE_JOBS=-j4
fi
SRC_ROOT=$(realpath $SCRIPT_ROOT/../src)
