git_clone https://anongit.freedesktop.org/git/fontconfig fontconfig
if [ $result == true ]; then return; fi
compile_with_configure fontconfig --enable-static --disable-shared --disable-docs --enable-iconv --enable-libxml2
