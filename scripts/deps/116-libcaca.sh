if [ "x${CACA_VERSION}" == "xgit" ]; then
    git_clone https://github.com/cacalabs/libcaca libcaca-${CACA_VERSION}
else
    download_file https://github.com/cacalabs/libcaca/archive/v${CACA_VERSION}.tar.gz libcaca-${CACA_VERSION}
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/libcaca-${CACA_VERSION}
sed -i -e 's,java doc,java,g' Makefile.am
sed -i -e 's,doc test,test,g' Makefile.am
if [ -f Makefile.in ]; then
    sed -i -e 's,java doc,java,g' Makefile.in
    sed -i -e 's,doc test,test,g' Makefile.in
fi
sed -i -e 's,defined _WIN32 && !defined __LIBCACA__ && !defined CACA_STATIC,0,g' caca/caca.h
sed -i -e 's,defined _WIN32 && !defined __LIBCACA__,0,g' caca/caca0.h
sed -i -e 's,^int vsnprintf(,int vsnprintf_dummy(,g' caca/string.c
sed -i -e 's,^int vsnprintf(,int vsnprintf_dummy(,g' caca/figfont.c
popd
compile_with_configure libcaca-${CACA_VERSION} --enable-static --disable-shared --disable-ncurses --disable-doc
