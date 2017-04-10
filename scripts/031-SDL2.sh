hg_clone http://hg.libsdl.org/SDL SDL2
if [ $result == true ]; then return; fi
cd $SRC_ROOT/SDL2
sed -i -e 's,XINPUT_GAMEPAD_EX;,XINPUT_GAMEPAD_EX2;,g' -e 's,XINPUT_STATE_EX;,XINPUT_STATE_EX2;,g' src/core/windows/SDL_xinput.h
compile_with_configure SDL2 --enable-static --disable-shared --disable-video-x11-xinput
