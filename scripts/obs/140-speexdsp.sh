if [ "x${SPEEXDSP_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/speexdsp.git speexdsp-${SPEEXDSP_VERSION}
else
    download_file http://downloads.xiph.org/releases/speex/speexdsp-${SPEEXDSP_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
compile_with_configure speexdsp-${SPEEXDSP_VERSION} --enable-shared --disable-static --disable-examples
