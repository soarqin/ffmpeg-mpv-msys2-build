if [ "x${ZIMG_VERSION}" == "xgit" ]; then
    git_clone https://github.com/sekrit-twc/zimg zimg-${ZIMG_VERSION}
else
    download_file https://github.com/sekrit-twc/zimg/archive/${ZIMG_VERSION}.tar.gz zimg-${ZIMG_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure zimg-${ZIMG_VERSION} --enable-static --disable-shared
