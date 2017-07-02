if [ "x${LIBILBC_VERSION}" == "xgit" ]; then
    git_clone https://github.com/TimothyGu/libilbc libilbc-${LIBILBC_VERSION}
else
    download_file https://github.com/TimothyGu/libilbc/releases/download/v${LIBILBC_VERSION}/libilbc-${LIBILBC_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libilbc-${LIBILBC_VERSION} --enable-static --disable-shared
