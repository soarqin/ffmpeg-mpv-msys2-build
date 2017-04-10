git_clone https://git.gnome.org/browse/libxml2 libxml2
if [ $result == true ]; then return; fi
compile_with_configure libxml2 --enable-static --disable-shared --without-readline --without-python
