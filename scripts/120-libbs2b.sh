git_clone https://github.com/alexmarsev/libbs2b libbs2b
if [ $result == true ]; then return; fi
compile_with_configure libbs2b --enable-static --disable-shared
