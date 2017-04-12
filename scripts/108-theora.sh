git_clone https://git.xiph.org/theora.git libtheora-git
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/libtheora-git
rm -f configure
dos2unix configure.ac
popd
compile_with_configure libtheora-git --enable-static --disable-shared --disable-examples --disable-oggtest --disable-vorbistest --disable-sdltest
