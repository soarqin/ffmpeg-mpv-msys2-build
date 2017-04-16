if [ "x${LIBSNDFILE_VERSION}" == "xgit" ]; then
    git_clone https://github.com/erikd/libsndfile libsndfile-${LIBSNDFILE_VERSION}
else
    download_file https://github.com/erikd/libsndfile/archive/${LIBSNDFILE_VERSION}.tar.gz libsndfile-${LIBSNDFILE_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure_dirty libsndfile-${LIBSNDFILE_VERSION} --enable-static --disable-shared --disable-full-suite
