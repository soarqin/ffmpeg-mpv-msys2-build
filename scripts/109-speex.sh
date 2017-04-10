git_clone https://git.xiph.org/speex.git speex
if [ $result == true ]; then return; fi
compile_with_configure speex --enable-static --disable-shared
