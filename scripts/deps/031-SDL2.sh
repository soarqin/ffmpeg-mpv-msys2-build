if [ "x${SDL2_VERSION}" == "xhg" ]; then
    hg_clone http://hg.libsdl.org/SDL SDL2-${SDL2_VERSION}
else
    download_file http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
patch_source SDL2-${SDL2_VERSION} 031-SDL2.patch
compile_with_configure SDL2-${SDL2_VERSION} --enable-static --disable-shared --disable-video-x11-xinput
