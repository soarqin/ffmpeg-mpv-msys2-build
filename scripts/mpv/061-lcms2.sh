if [ "x${LCMS2_VERSION}" == "xgit" ]; then
    git_clone https://github.com/mm2/Little-CMS lcms2-${LCMS2_VERSION}
else
    download_file https://sourceforge.net/projects/lcms/files/lcms/2.8/lcms2-${LCMS2_VERSION}.tar.gz/download lcms2-${LCMS2_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_configure lcms2-${LCMS2_VERSION} --enable-static --disable-shared
