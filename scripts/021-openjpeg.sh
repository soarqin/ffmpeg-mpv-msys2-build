OPENJPEG_VERSION=2.1.2
download_file https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz openjpeg-${OPENJPEG_VERSION}
if [ $result == true ]; then return; fi
cd $SRC_ROOT/openjpeg-${OPENJPEG_VERSION}
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openjp2/openjpeg.h
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openjp3d/openjp3d.h
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openmj2/openjpeg.h
compile_with_cmake openjpeg-${OPENJPEG_VERSION} -DBUILD_SHARED_LIBS=Off -DBUILD_CODEC=Off
