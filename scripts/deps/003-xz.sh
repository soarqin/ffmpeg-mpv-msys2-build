if [ "x${XZ_VERSION}" == "xgit" ]; then
    git_clone https://git.tukaani.org/xz.git xz-${XZ_VERSION}
else
    download_file https://tukaani.org/xz/xz-${XZ_VERSION}.tar.xz
fi
if [ $result == true ]; then return; fi
compile_with_configure xz-${XZ_VERSION} --enable-static --disable-shared --disable-rpath --disable-nls
