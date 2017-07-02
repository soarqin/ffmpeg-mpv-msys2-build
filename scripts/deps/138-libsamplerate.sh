if [ "x${LIBSAMPLERATE_VERSION}" == "xgit" ]; then
    git_clone https://github.com/erikd/libsamplerate libsamplerate-${LIBSAMPLERATE_VERSION}
else
    download_file http://www.mega-nerd.com/SRC/libsamplerate-${LIBSAMPLERATE_VERSION}.tar.gz
    if [ "$result" = true ]; then return; fi
    patch_source libsamplerate-${LIBSAMPLERATE_VERSION} 138-libsamplerate.patch
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libsamplerate-${LIBSAMPLERATE_VERSION} --enable-static --disable-shared --disable-alsa
