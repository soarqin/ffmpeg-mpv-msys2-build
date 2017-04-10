git_clone https://git.xiph.org/opus.git opus
if [ $result == true ]; then return; fi
compile_with_configure opus --enable-static --disable-shared --disable-doc --disable-extra-programs
