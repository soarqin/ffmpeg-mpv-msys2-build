download_file https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz openjpeg-${OPENJPEG_VERSION}
if [ $result == true ]; then return; fi
patch_source openjpeg-${OPENJPEG_VERSION} 021-openjpeg.patch 1
compile_with_cmake openjpeg-${OPENJPEG_VERSION} -DBUILD_SHARED_LIBS=Off -DBUILD_CODEC=Off
