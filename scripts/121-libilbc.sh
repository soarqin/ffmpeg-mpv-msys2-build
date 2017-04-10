git_clone https://github.com/TimothyGu/libilbc libilbc
if [ $result == true ]; then return; fi
compile_with_configure libilbc --enable-static --disable-shared
