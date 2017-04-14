if [ "x${ORC_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/gstreamer/orc.git orc-${ORC_VERSION}
else
    download_file https://gstreamer.freedesktop.org/src/orc/orc-${ORC_VERSION}.tar.xz
fi
if [ $result == true ]; then return; fi
compile_with_configure orc-${ORC_VERSION} --enable-static --disable-shared
