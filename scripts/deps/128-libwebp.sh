if [ "x${WEBP_VERSION}" == "xgit" ]; then
    git_clone https://chromium.googlesource.com/webm/libwebp libwebp-${WEBP_VERSION}
else
    download_file https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${WEBP_VERSION}.tar.gz
fi
if [ "$result" = true ]; then return; fi
pushd $SRC_ROOT/libwebp-${WEBP_VERSION}
dos2unix configure.ac
popd
compile_with_configure libwebp-${WEBP_VERSION} --enable-static --disable-shared
