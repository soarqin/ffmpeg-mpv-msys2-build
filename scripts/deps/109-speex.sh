if [ "x${SPEEX_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/speex.git speex-${SPEEX_VERSION}
else
    download_file http://downloads.xiph.org/releases/speex/speex-${SPEEX_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
compile_with_configure speex-${SPEEX_VERSION} --enable-static --disable-shared
