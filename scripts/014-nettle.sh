git_clone https://git.lysator.liu.se/nettle/nettle nettle
if [ $result == true ]; then return; fi
compile_with_configure nettle --enable-static --disable-shared --disable-openssl --disable-documentation
