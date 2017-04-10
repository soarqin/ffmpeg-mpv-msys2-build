git_clone https://git.xiph.org/vorbis.git vorbis
if [ $result == true ]; then return; fi
compile_with_configure vorbis --enable-static --disable-shared --disable-oggtest
