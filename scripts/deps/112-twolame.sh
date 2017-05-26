if [ "x${TWOLAME_VERSION}" == "xgit" ]; then
    git_clone https://github.com/njh/twolame twolame-${TWOLAME_VERSION}
else
    download_file http://downloads.sourceforge.net/twolame/twolame-${TWOLAME_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
patch_source twolame-${TWOLAME_VERSION} 112-twolame.patch
pushd $SRC_ROOT/twolame-${TWOLAME_VERSION}
dos2unix configure.ac
popd
compile_with_configure twolame-${TWOLAME_VERSION} --enable-static --disable-shared
