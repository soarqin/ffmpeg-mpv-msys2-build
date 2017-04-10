git_clone https://github.com/ultravideo/kvazaar kvazaar
if [ $result == true ]; then return; fi
cd $SRC_ROOT/kvazaar
sed -i -e 's,defined(KVZ_STATIC_LIB),1,g' src/kvazaar.h
compile_with_configure kvazaar --enable-static --disable-shared
