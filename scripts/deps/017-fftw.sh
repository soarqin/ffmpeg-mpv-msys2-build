download_file http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz
if [ $result == true ]; then return; fi
compile_with_configure fftw-${FFTW_VERSION} --enable-static --disable-shared --enable-sse2 --enable-avx --enable-threads --with-combined-threads --with-our-malloc --without-g77-wrappers --without-windows-f77-mangling
