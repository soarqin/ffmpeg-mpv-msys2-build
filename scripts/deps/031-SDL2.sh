if [ "x${SDL2_VERSION}" == "xhg" ]; then
    hg_clone http://hg.libsdl.org/SDL SDL2-${SDL2_VERSION}
else
    download_file http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/SDL2-${SDL2_VERSION}
sed -i -e 's,XINPUT_GAMEPAD_EX;,XINPUT_GAMEPAD_EX2;,g' -e 's,XINPUT_STATE_EX;,XINPUT_STATE_EX2;,g' src/core/windows/SDL_xinput.h
popd
compile_with_configure SDL2-${SDL2_VERSION} --enable-static --disable-shared --disable-video-x11-xinput
