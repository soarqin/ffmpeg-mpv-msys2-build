git_clone https://git.xiph.org/theora.git theora
cd $SRC_ROOT/theora
dos2unix configure.ac
compile_with_configure theora --enable-static --disable-shared --disable-examples --disable-oggtest --disable-vorbistest --disable-sdltest
