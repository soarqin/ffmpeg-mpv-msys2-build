if [ "x${FONTCONFIG_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/fontconfig fontconfig-${FONTCONFIG_VERSION}
    if [ "$result" = true ]; then return; fi
    patch_source fontconfig-${FONTCONFIG_VERSION} 026-fontconfig.patch
else
    download_file https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2
    if [ "$result" = true ]; then return; fi
    patch_source fontconfig-${FONTCONFIG_VERSION} 026-fontconfig.patch
    patch_source fontconfig-${FONTCONFIG_VERSION} 026-fontconfig-2.patch
fi
compile_with_configure fontconfig-${FONTCONFIG_VERSION} --enable-static --disable-shared --disable-docs --enable-iconv --enable-libxml2
