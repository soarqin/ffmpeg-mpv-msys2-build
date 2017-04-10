git_clone https://github.com/mstorsjo/fdk-aac fdk-aac
if [ $result == true ]; then return; fi
compile_with_configure fdk-aac --enable-static --disable-shared
