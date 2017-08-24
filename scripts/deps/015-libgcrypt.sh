download_file https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${LIBGCRYPT_VERSION}.tar.bz2
if [ "$result" = true ]; then return; fi
if [ "x${ARCH}" == "x64" ]; then
    ac_cv_sys_symbol_underscore=no compile_with_configure libgcrypt-${LIBGCRYPT_VERSION} --enable-static --disable-shared --with-gpg-error-prefix=${BUILD_INSTALL_ROOT}
else
    compile_with_configure libgcrypt-${LIBGCRYPT_VERSION} --enable-static --disable-shared --with-gpg-error-prefix=${BUILD_INSTALL_ROOT}
fi
