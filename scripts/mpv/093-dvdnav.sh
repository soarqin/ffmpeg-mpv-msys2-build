if [ "x${DVDNAV_VERSION}" == "xgit" ]; then
    git_clone https://code.videolan.org/videolan/libdvdnav.git libdvdnav-${DVDNAV_VERSION}
else
    download_file http://download.videolan.org/pub/videolan/libdvdnav/${DVDNAV_VERSION}/libdvdnav-${DVDNAV_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libdvdnav-${DVDNAV_VERSION} --enable-static --disable-shared
