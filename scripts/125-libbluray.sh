git_clone http://git.videolan.org/git/libbluray.git libbluray
if [ $result == true ]; then return; fi
compile_with_configure libbluray --enable-static --disable-shared --disable-doxygen-doc --disable-doxygen-dot --disable-doxygen-html --disable-doxygen-ps --disable-doxygen-pdf --disable-doxygen-man --disable-doxygen-rtf --disable-doxygen-xml --disable-doxygen-chm --disable-doxygen-chi --disable-examples --disable-bdjava --disable-bdjava-jar
