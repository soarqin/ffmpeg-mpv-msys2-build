git_clone https://github.com/cacalabs/libcaca libcaca
cd $SRC_ROOT/libcaca
sed -i -e 's,defined _WIN32 && !defined __LIBCACA__ && !defined CACA_STATIC,0,g' caca/caca.h
sed -i -e 's,defined _WIN32 && !defined __LIBCACA__,0,g' caca/caca0.h
compile_with_configure libcaca --enable-static --disable-shared --disable-ncurses
