if [ "x${MFX_VERSION}" == "xgit" ]; then
    git_clone https://github.com/lu-zero/mfx_dispatch mfx_dispatch-${MFX_VERSION}
else
    download_file https://github.com/lu-zero/mfx_dispatch/archive/${MFX_VERSION}.tar.gz mfx_dispatch-${MFX_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_configure mfx_dispatch-${MFX_VERSION} --enable-static --disable-shared
