git_clone https://github.com/mcfiredrill/libgme libgme
cd $SRC_ROOT/libgme
sed -i -e 's,SHARED,STATIC,g' gme/CMakeLists.txt
compile_with_cmake libgme
