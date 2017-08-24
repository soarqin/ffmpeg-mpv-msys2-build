if [ "x${LIBBLURAY_VERSION}" == "xgit" ]; then
    git_clone http://git.videolan.org/git/libbluray.git libbluray-${LIBBLURAY_VERSION}
    if [ "$result" = true ]; then return; fi
    patch_source libbluray-${LIBBLURAY_VERSION} 125-libbluray-git.patch
else
    download_file https://ftp.videolan.org/pub/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
rm -f ${SRC_ROOT}/libbluray-${LIBBLURAY_VERSION}/configure
compile_with_configure libbluray-${LIBBLURAY_VERSION} --enable-static --disable-shared --disable-doxygen-doc --disable-doxygen-dot --disable-doxygen-html --disable-doxygen-ps --disable-doxygen-pdf --disable-doxygen-man --disable-doxygen-rtf --disable-doxygen-xml --disable-doxygen-chm --disable-doxygen-chi --disable-examples --disable-bdjava --disable-bdjava-jar
