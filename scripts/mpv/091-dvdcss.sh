if [ "x${DVDCSS_VERSION}" == "xgit" ]; then
    git_clone https://code.videolan.org/videolan/libdvdcss.git libdvdcss-${DVDCSS_VERSION}
else
    download_file http://download.videolan.org/pub/videolan/libdvdcss/${DVDCSS_VERSION}/libdvdcss-${DVDCSS_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libdvdcss-${DVDCSS_VERSION} --enable-static --disable-shared --disable-doc
