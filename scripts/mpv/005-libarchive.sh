if [ "x${LIBARCHIVE_VERSION}" == "xgit" ]; then
    git_clone https://github.com/libarchive/libarchive libarchive-${LIBARCHIVE_VERSION}
    if [ $result == true ]; then return; fi
    patch_source libarchive-${LIBARCHIVE_VERSION} 005-libarchive.patch
else
    download_file https://github.com/libarchive/libarchive/archive/v${LIBARCHIVE_VERSION}.tar.gz libarchive-${LIBARCHIVE_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure libarchive-${LIBARCHIVE_VERSION} --enable-static --disable-shared --disable-rpath --without-iconv --disable-bsdtar --disable-bsdcat --disable-bsdcpio --without-lz4 --without-openssl --without-xml2 --without-expat --without-cng
