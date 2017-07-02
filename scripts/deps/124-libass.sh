if [ "x${LIBASS_VERSION}" == "xgit" ]; then
    git_clone https://github.com/libass/libass libass-${LIBASS_VERSION}
else
    download_file https://github.com/libass/libass/releases/download/${LIBASS_VERSION}/libass-${LIBASS_VERSION}.tar.xz
fi
if [ "$result" = true ]; then return; fi
compile_with_configure libass-${LIBASS_VERSION} --enable-static --disable-shared --disable-test --enable-harfbuzz
