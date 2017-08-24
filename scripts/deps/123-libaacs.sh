if [ "x${LIBAACS_VERSION}" == "xgit" ]; then
    git_clone http://git.videolan.org/git/libaacs.git libaacs-${LIBAACS_VERSION}
else
    download_file https://ftp.videolan.org/pub/videolan/libaacs/${LIBAACS_VERSION}/libaacs-${LIBAACS_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
rm -f ${SRC_ROOT}/libaacs-${LIBAACS_VERSION}/configure
compile_with_configure libaacs-${LIBAACS_VERSION} --enable-shared --disable-static
