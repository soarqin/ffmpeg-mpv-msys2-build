if [ "x${WAVPACK_VERSION}" == "xgit" ]; then
    git_clone https://github.com/dbry/WavPack WavPack-${WAVPACK_VERSION}
else
    download_file https://github.com/dbry/WavPack/archive/${WAVPACK_VERSION}.tar.gz WavPack-${WAVPACK_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_configure WavPack-${WAVPACK_VERSION} --enable-static --disable-shared --disable-apps --disable-rpath --disable-tests
