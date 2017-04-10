git_clone http://git.tukaani.org/xz.git xz
if [ $result == true ]; then return; fi
compile_with_configure xz --enable-static --disable-shared --disable-rpath --disable-nls
