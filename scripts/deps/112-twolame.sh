if [ "x${TWOLAME_VERSION}" == "xgit" ]; then
    git_clone https://github.com/njh/twolame twolame-${TWOLAME_VERSION}
else
    download_file http://downloads.sourceforge.net/twolame/twolame-${TWOLAME_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/twolame-${TWOLAME_VERSION}
dos2unix configure.ac
sed -i -e 's, doc tests,,g' Makefile.am
sed -i -e 's,#ifdef LIBTWOLAME_STATIC,#if 1,g' libtwolame/twolame.h
popd
compile_with_configure twolame-${TWOLAME_VERSION} --enable-static --disable-shared
