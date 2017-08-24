git_clone https://git.xiph.org/theora.git libtheora-${THEORA_VERSION}
if [ "$result" = true ]; then return; fi
pushd $SRC_ROOT/libtheora-${THEORA_VERSION}
rm -f configure
dos2unix configure.ac
popd
compile_with_configure libtheora-${THEORA_VERSION} --enable-static --disable-shared --disable-examples --disable-oggtest --disable-vorbistest --disable-sdltest
