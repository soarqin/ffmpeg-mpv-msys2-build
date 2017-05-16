if [ "x${THEORA_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/theora.git libtheora-${THEORA_VERSION}
else
    download_file http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.xz
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/libtheora-git
rm -f configure
dos2unix configure.ac
popd
compile_with_configure libtheora-git --enable-static --disable-shared --disable-examples --disable-oggtest --disable-vorbistest --disable-sdltest
