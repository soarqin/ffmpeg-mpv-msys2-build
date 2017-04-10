git_clone https://github.com/libass/libass libass
if [ $result == true ]; then return; fi
compile_with_configure libass --enable-static --disable-shared --disable-test --disable-harfbuzz
