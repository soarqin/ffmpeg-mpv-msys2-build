if [ "x${OPUS_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/opus.git opus-${OPUS_VERSION}
else
    download_file https://archive.mozilla.org/pub/opus/opus-${OPUS_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
compile_with_configure opus-${OPUS_VERSION} --enable-static --disable-shared --disable-doc --disable-extra-programs --enable-custom-modes
