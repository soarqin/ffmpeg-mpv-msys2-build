git_clone https://git.savannah.gnu.org/git/libunistring.git libunistring
cd $SRC_ROOT/libunistring
if [ ! -f ./configure ]; then
    ./autogen.sh
fi
compile_with_configure libunistring --enable-static --disable-shared --enable-threads=windows --disable-rpath
