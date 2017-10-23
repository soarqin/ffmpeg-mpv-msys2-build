if [ "x${OPENJPEG_VERSION}" == "xgit" ]; then
    git_clone https://github.com/uclouvain/openjpeg openjpeg-${OPENJPEG_VERSION}
else
    download_file https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz openjpeg-${OPENJPEG_VERSION}
fi
if [ "$result" = true ]; then return; fi
compile_with_cmake openjpeg-${OPENJPEG_VERSION} -DBUILD_SHARED_LIBS=Off -DBUILD_CODEC=Off
