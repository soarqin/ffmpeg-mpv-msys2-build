if [ "x${DVDREAD_VERSION}" == "xgit" ]; then
    git_clone https://code.videolan.org/videolan/libdvdread.git libdvdread-${DVDREAD_VERSION}
else
    download_file http://download.videolan.org/pub/videolan/libdvdread/${DVDREAD_VERSION}/libdvdread-${DVDREAD_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libdvdread-${DVDREAD_VERSION} --enable-static --disable-shared --disable-apidoc --with-libdvdcss
