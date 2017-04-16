if [ "x${LIBJPEG_TURBO_VERSION}" == "xgit" ]; then
    git_clone https://github.com/libjpeg-turbo/libjpeg-turbo libjpeg-turbo-${LIBJPEG_TURBO_VERSION}
else
    download_file https://github.com/libjpeg-turbo/libjpeg-turbo/archive/${LIBJPEG_TURBO_VERSION}.tar.gz libjpeg-turbo-${LIBJPEG_TURBO_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure libjpeg-turbo-${LIBJPEG_TURBO_VERSION} --enable-static --disable-shared
