git_clone https://github.com/cython/cython cython-git
if [ "x${VAPOURSYNTH_VERSION}" == "xgit" ]; then
    git_clone https://github.com/vapoursynth/vapoursynth vapoursynth-${VAPOURSYNTH_VERSION}
else
    download_file https://github.com/vapoursynth/vapoursynth/archive/${VAPOURSYNTH_VERSION}.tar.gz vapoursynth-${VAPOURSYNTH_VERSION}
fi
if [ "$result" = true ]; then return; fi
patch_source vapoursynth-${VAPOURSYNTH_VERSION} 062-vapoursynth.patch
export OLD_PATH=${PATH}
export PATH=${SRC_ROOT}/cython-git/bin:${PATH}
export PYTHONPATH=${SRC_ROOT}/cython-git
compile_with_configure vapoursynth-${VAPOURSYNTH_VERSION} --enable-static --disable-shared
export PATH=${OLD_PATH}
