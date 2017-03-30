git_clone git://anongit.freedesktop.org/git/cairo cairo
cd $SRC_ROOT/cairo
touch boilerplate/Makefile.am.features
touch src/Makefile.am.features
touch ChangeLog
compile_with_configure cairo --enable-static --disable-shared --disable-valgrind
