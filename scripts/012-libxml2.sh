if [ "x${LIBXML2_VERSION}" == "xgit" ]; then
    git_clone https://git.gnome.org/browse/libxml2 libxml2-${LIBXML2_VERSION}
else
    download_file ftp://xmlsoft.org/libxml2/libxml2-${LIBXML2_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
compile_with_configure libxml2-${LIBXML2_VERSION} --enable-static --disable-shared --without-readline --without-python
