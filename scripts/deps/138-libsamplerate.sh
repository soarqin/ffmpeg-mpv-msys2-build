if [ "x${LIBSAMPLERATE_VERSION}" == "xgit" ]; then
    git_clone https://github.com/erikd/libsamplerate libsamplerate-${LIBSAMPLERATE_VERSION}
else
    download_file http://www.mega-nerd.com/SRC/libsamplerate-${LIBSAMPLERATE_VERSION}.tar.gz
    pushd $SRC_ROOT/libsamplerate-${LIBSAMPLERATE_VERSION}
    if [ ! -f ./patched ]; then
        patch -p1 < ${PATCH_ROOT}/138-libsamplerate.patch
        touch ./patched
    fi
    popd
fi
if [ $result == true ]; then return; fi
compile_with_configure libsamplerate-${LIBSAMPLERATE_VERSION} --enable-static --disable-shared --disable-alsa
