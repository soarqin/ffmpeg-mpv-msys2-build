git_clone https://chromium.googlesource.com/webm/libwebp libwebp
cd $SRC_ROOT/libwebp
dos2unix configure.ac
compile_with_configure libwebp --enable-static --disable-shared
