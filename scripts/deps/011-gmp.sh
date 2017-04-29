download_file https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.xz
if [ $result == true ]; then return; fi
compile_with_configure gmp-${GMP_VERSION} --enable-static --disable-shared
