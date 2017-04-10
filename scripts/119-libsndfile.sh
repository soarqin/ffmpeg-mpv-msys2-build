git_clone https://github.com/erikd/libsndfile libsndfile
if [ $result == true ]; then return; fi
compile_with_configure_dirty libsndfile --enable-static --disable-shared --disable-full-suite
