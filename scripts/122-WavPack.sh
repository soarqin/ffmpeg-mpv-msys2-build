git_clone https://github.com/dbry/WavPack WavPack
if [ $result == true ]; then return; fi
compile_with_configure WavPack --enable-static --disable-shared --disable-apps --disable-rpath --disable-tests
