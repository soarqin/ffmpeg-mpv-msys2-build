git_clone https://github.com/lu-zero/mfx_dispatch mfx
if [ $result == true ]; then return; fi
compile_with_configure mfx --enable-static --disable-shared
