if [ "x${LIBVPX_VERSION}" == "xgit" ]; then
    git_clone https://chromium.googlesource.com/webm/libvpx libvpx-${LIBVPX_VERSION}
else
    download_file http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-${LIBVPX_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
compile_with_configure libvpx-${LIBVPX_VERSION} --enable-static --disable-shared --disable-examples --disable-tools --disable-docs --enable-runtime-cpu-detect --disable-unit-tests --disable-decode-perf-tests --disable-encode-perf-tests
