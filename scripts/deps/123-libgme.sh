if [ "x${GME_VERSION}" == "xgit" ]; then
    git_clone https://bitbucket.org/mpyne/game-music-emu game-music-emu-${GME_VERSION}
    rm -f ${SRC_ROOT}/game-music-emu-${GME_VERSION}/patched
else
    download_file https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-${GME_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
pushd ${SRC_ROOT}/game-music-emu-${GME_VERSION}
if [ ! -f ./patched ]; then
    patch -p1 < ${PATCH_ROOT}/123-libgme.patch
    touch ./patched
fi
popd
compile_with_cmake game-music-emu-${GME_VERSION} -DBUILD_SHARED_LIBS=OFF -DENABLE_UBSAN=OFF
