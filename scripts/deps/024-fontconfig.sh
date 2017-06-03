if [ "x${FONTCONFIG_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/fontconfig fontconfig-${FONTCONFIG_VERSION}
else
    download_file https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
patch_source fontconfig-${FONTCONFIG_VERSION} 024-fontconfig.patch
compile_with_configure fontconfig-${FONTCONFIG_VERSION} --enable-static --disable-shared --disable-docs --enable-iconv --enable-libxml2
