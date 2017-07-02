if [ "x${GME_VERSION}" == "xgit" ]; then
    git_clone https://bitbucket.org/mpyne/game-music-emu game-music-emu-${GME_VERSION}
else
    download_file https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-${GME_VERSION}.tar.bz2
fi
if [ "$result" = true ]; then return; fi
patch_source game-music-emu-${GME_VERSION} 123-libgme.patch
compile_with_cmake game-music-emu-${GME_VERSION} -DBUILD_SHARED_LIBS=OFF -DENABLE_UBSAN=OFF
