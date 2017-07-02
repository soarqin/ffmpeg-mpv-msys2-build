if [ "x${VORBIS_VERSION}" == "xgit" ]; then
    git_clone https://git.xiph.org/vorbis.git libvorbis-${VORBIS_VERSION}
else
    download_file http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.xz
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libvorbis-${VORBIS_VERSION} --enable-static --disable-shared --disable-oggtest
