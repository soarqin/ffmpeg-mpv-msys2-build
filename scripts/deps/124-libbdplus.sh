if [ "x${LIBBDPLUS_VERSION}" == "xgit" ]; then
    git_clone http://git.videolan.org/git/libbdplus.git libbdplus-${LIBBDPLUS_VERSION}
else
    download_file https://ftp.videolan.org/pub/videolan/libbdplus/${LIBBDPLUS_VERSION}/libbdplus-${LIBBDPLUS_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
rm -f ${SRC_ROOT}/libbdplus-${LIBBDPLUS_VERSION}/configure
compile_with_configure libbdplus-${LIBBDPLUS_VERSION} --enable-shared --disable-static
