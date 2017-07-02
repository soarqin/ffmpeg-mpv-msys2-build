download_file https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2
if [ "$result" = true ]; then return; fi
compile_with_configure curl-${CURL_VERSION} --enable-shared --disable-static --enable-optimize --disable-curldebug --enable-symbol-hiding --disable-pthreads --enable-sspi --with-zlib --without-ssl --without-gnutls --with-winssl --without-libssh2 --without-nghttp2 --with-winidn --without-libidn2 --without-librtmp
