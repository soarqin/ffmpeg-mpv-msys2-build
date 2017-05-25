if [ "x${FREI0R_VERSION}" == "xgit" ]; then
    git_clone https://code.dyne.org/frei0r frei0r-plugins-${FREI0R_VERSION}
else
    download_file https://files.dyne.org/frei0r/frei0r-plugins-${FREI0R_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
patch_source frei0r-plugins-${FREI0R_VERSION} 102-frei0r.patch 1
compile_with_configure_dirty frei0r-plugins-${FREI0R_VERSION} --enable-static --disable-shared
