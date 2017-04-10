git_clone https://github.com/sekrit-twc/zimg zimg
if [ $result == true ]; then return; fi
compile_with_configure zimg --enable-static --disable-shared
