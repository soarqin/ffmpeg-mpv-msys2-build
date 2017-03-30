download_file https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.10.tar.xz
compile_with_configure gnutls-3.5.10 --enable-static --disable-shared --disable-doc --disable-tools --disable-tests --disable-nls --disable-rpath --disable-valgrind-tests --disable-full-test-suite --enable-local-libopts --with-included-libtasn1 --without-p11-kit
