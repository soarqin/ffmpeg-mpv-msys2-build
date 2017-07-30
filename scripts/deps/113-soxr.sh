if [ "x${SOXR_VERSION}" == "xgit" ]; then
    git_clone https://git.code.sf.net/p/soxr/code soxr-${SOXR_VERSION}
else
    download_file https://sourceforge.net/projects/soxr/files/soxr-${SOXR_VERSION}-Source.tar.xz/download soxr-${SOXR_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_cmake soxr-${SOXR_VERSION} -DBUILD_SHARED_LIBS=Off -DBUILD_TESTS=Off -DWITH_OPENMP=Off
