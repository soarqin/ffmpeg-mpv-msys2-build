if [ "x${UCHARDET_VERSION}" == "xgit" ]; then
    git_clone https://anongit.freedesktop.org/git/uchardet/uchardet.git uchardet-${UCHARDET_VERSION}
else
    download_file https://www.freedesktop.org/software/uchardet/releases/uchardet-${UCHARDET_VERSION}.tar.xz
fi
if [ $result == true ]; then return; fi
compile_with_cmake uchardet-${UCHARDET_VERSION} -DBUILD_SHARED_LIBS=OFF -DBUILD_BINARY=OFF
