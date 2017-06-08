if [ "x${FREI0R_VERSION}" == "xgit" ]; then
    git_clone http://code.dyne.org/frei0r frei0r-plugins-${FREI0R_VERSION}
else
    download_file http://files.dyne.org/frei0r/frei0r-plugins-${FREI0R_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
pushd ${SRC_ROOT}/frei0r-plugins-${FREI0R_VERSION}
touch README TODO ChangeLog AUTHORS
rm -f configure
popd
patch_source frei0r-plugins-${FREI0R_VERSION} 102-frei0r.patch
compile_with_configure_dirty frei0r-plugins-${FREI0R_VERSION} --enable-static --disable-shared
