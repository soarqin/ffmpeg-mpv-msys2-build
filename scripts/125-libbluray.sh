if [ "x${LIBBLUERAY_VERSION}" == "xgit" ]; then
    git_clone http://git.videolan.org/git/libbluray.git libbluray-${LIBBLUERAY_VERSION}
else
    download_file https://ftp.videolan.org/pub/videolan/libbluray/${LIBBLUERAY_VERSION}/libbluray-${LIBBLUERAY_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
compile_with_configure libbluray-${LIBBLUERAY_VERSION} --enable-static --disable-shared --disable-doxygen-doc --disable-doxygen-dot --disable-doxygen-html --disable-doxygen-ps --disable-doxygen-pdf --disable-doxygen-man --disable-doxygen-rtf --disable-doxygen-xml --disable-doxygen-chm --disable-doxygen-chi --disable-examples --disable-bdjava --disable-bdjava-jar
