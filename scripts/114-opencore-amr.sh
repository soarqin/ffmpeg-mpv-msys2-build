git_clone https://git.code.sf.net/p/opencore-amr/code opencore-amr
if [ $result == true ]; then return; fi
compile_with_configure opencore-amr --enable-static --disable-shared
