git_clone https://github.com/chirlu/soxr soxr-git
if [ "$result" = true ]; then return; fi
compile_with_cmake soxr-git -DBUILD_SHARED_LIBS=Off -DBUILD_TESTS=Off -DWITH_OPENMP=Off
