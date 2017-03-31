git_clone https://chromium.googlesource.com/webm/libvpx libvpx
compile_with_configure libvpx --enable-static --disable-shared --disable-examples --disable-tools --disable-docs --enable-runtime-cpu-detect --disable-unit-tests --disable-decode-perf-tests --disable-encode-perf-tests
