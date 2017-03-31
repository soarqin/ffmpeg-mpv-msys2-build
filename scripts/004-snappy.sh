git_clone https://github.com/google/snappy snappy
cd $SRC_ROOT/snappy
cp README.md README
compile_with_configure snappy --enable-static --disable-shared
