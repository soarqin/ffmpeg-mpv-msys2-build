download_file http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz
if [ "$result" = true ]; then return; fi
compile_with_configure lzo-${LZO_VERSION} --enable-static --disable-shared
