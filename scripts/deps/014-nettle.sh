if [ "x${NETTLE_VERSION}" == "xgit" ]; then
    git_clone https://git.lysator.liu.se/nettle/nettle nettle-${NETTLE_VERSION}
else
    download_file https://ftp.gnu.org/gnu/nettle/nettle-${NETTLE_VERSION}.tar.gz
fi
if [ "$result" = true ]; then return; fi
compile_with_configure nettle-${NETTLE_VERSION} --enable-static --disable-shared --disable-openssl --disable-documentation
