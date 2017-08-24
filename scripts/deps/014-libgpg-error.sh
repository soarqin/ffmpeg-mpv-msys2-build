download_file https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2
if [ "$result" = true ]; then return; fi
compile_with_configure libgpg-error-${LIBGPG_ERROR_VERSION} --enable-static --disable-shared --disable-nls --disable-languages
