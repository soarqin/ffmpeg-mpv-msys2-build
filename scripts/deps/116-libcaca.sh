if [ "x${CACA_VERSION}" == "xgit" ]; then
    git_clone https://github.com/cacalabs/libcaca libcaca-${CACA_VERSION}
    if [ $result == true ]; then return; fi
    patch_source libcaca-${CACA_VERSION} 116-libcaca.patch
else
    download_file https://github.com/cacalabs/libcaca/archive/v${CACA_VERSION}.tar.gz libcaca-${CACA_VERSION}
    if [ $result == true ]; then return; fi
    patch_source libcaca-${CACA_VERSION} 116-libcaca.patch
    patch_source libcaca-${CACA_VERSION} 116-libcaca-2.patch
fi
compile_with_configure libcaca-${CACA_VERSION} --enable-static --disable-shared --disable-ncurses --disable-doc
