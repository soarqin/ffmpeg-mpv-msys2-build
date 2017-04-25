download_file https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-${GNUTLS_VERSION}.tar.xz
if [ $result == true ]; then return; fi
compile_with_configure gnutls-${GNUTLS_VERSION} --enable-static --disable-shared --disable-doc --disable-tools --disable-tests --disable-nls --disable-rpath --disable-valgrind-tests --disable-full-test-suite --enable-local-libopts --with-included-unistring --with-included-libtasn1 --without-p11-kit --without-idn --without-libidn2
sed -i -e 's,-lgmp,-lgmp -lcrypt32,g' $BUILD_INSTALL_ROOT/lib/pkgconfig/gnutls.pc