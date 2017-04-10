git_clone https://git.xiph.org/ogg.git ogg
if [ $result == true ]; then return; fi
compile_with_configure ogg --enable-static --disable-shared
