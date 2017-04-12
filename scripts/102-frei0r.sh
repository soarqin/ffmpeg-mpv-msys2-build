if [ "x${FREI0R_VERSION}" == "xgit" ]; then
    git_clone https://code.dyne.org/frei0r frei0r-plugins-${FREI0R_VERSION}
else
    download_file https://files.dyne.org/frei0r/frei0r-plugins-${FREI0R_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/frei0r-plugins-${FREI0R_VERSION}
touch README AUTHORS ChangeLog TODO
if [ ! -f ./Makefile.in ]; then
    rm -f configure
fi
mkdir -p m4
sed -i -e 's,$(DESTDIR)/,$(DESTDIR),g' -e 's,\.la`\.so,\.la`\.a,g' src/Makefile.am
popd
compile_with_configure_dirty frei0r-plugins-${FREI0R_VERSION} --enable-static --disable-shared
