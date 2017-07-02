if [ "x${LIBFFI_VERSION}" == "xgit" ]; then
    git_clone https://github.com/libffi/libffi libffi-${LIBFFI_VERSION}
else
    download_file http://sourceware.org/pub/libffi/libffi-${LIBFFI_VERSION}.tar.gz libffi-${LIBFFI_VERSION}
    if [ "$result" = true ]; then return; fi
    patch_source libffi-${LIBFFI_VERSION} 009-libffi.patch
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libffi-${LIBFFI_VERSION} --enable-static --disable-shared
