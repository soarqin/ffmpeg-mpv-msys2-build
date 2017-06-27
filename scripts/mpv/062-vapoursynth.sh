if [ "x${VAPOURSYNTH_VERSION}" == "xgit" ]; then
    git_clone https://github.com/vapoursynth/vapoursynth vapoursynth-${VAPOURSYNTH_VERSION}
else
    download_file https://github.com/vapoursynth/vapoursynth/archive/${VAPOURSYNTH_VERSION}.tar.gz vapoursynth-${VAPOURSYNTH_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure vapoursynth-${VAPOURSYNTH_VERSION} --enable-static --disable-shared
