if [ "x${OGG_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/ogg.git libogg-${OGG_VERSION}
else
    download_file http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.xz
fi
if [ $result == true ]; then return; fi
compile_with_configure libogg-${OGG_VERSION} --enable-static --disable-shared
