git_clone https://github.com/njh/twolame twolame
if [ $result == true ]; then return; fi
cd $SRC_ROOT/twolame
dos2unix configure.ac
sed -i -e 's, doc tests,,g' Makefile.am
sed -i -e 's,#ifdef LIBTWOLAME_STATIC,#if 1,g' libtwolame/twolame.h
compile_with_configure twolame --enable-static --disable-shared
