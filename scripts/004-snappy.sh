git_clone https://github.com/google/snappy snappy
if [ $result == true ]; then return; fi
cd $SRC_ROOT/snappy
cp README.md README
compile_with_configure snappy --enable-static --disable-shared
