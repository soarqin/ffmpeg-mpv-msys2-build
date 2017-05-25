if [ "x${GME_VERSION}" == "xgit" ]; then
    git_clone https://bitbucket.org/mpyne/game-music-emu game-music-emu-${GME_VERSION}
    patch -p1 < ${PATCH_ROOT}/123-libgme.patch
else
    download_file https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-${GME_VERSION}.tar.bz2
    patch_source game-music-emu-${GME_VERSION} 123-libgme.patch 1
fi
if [ $result == true ]; then return; fi
compile_with_cmake game-music-emu-${GME_VERSION} -DBUILD_SHARED_LIBS=OFF -DENABLE_UBSAN=OFF
