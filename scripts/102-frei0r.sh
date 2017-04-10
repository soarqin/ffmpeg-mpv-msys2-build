git_clone https://code.dyne.org/frei0r frei0r
if [ $result == true ]; then return; fi
cd $SRC_ROOT/frei0r
touch README
mkdir -p m4
sed -i -e 's,$(DESTDIR)/,$(DESTDIR),g' -e 's,\.la`\.so,\.la`\.a,g' src/Makefile.am
compile_with_configure_dirty frei0r --enable-static --disable-shared
