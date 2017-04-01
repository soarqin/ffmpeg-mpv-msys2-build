download_file https://github.com/uclouvain/openjpeg/archive/v2.1.2.tar.gz openjpeg-2.1.2
cd $SRC_ROOT/openjpeg-2.1.2
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openjp2/openjpeg.h
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openjp3d/openjp3d.h
sed -i -e 's,defined(OPJ_STATIC),1,g' src/lib/openmj2/openjpeg.h
compile_with_cmake openjpeg-2.1.2 -DBUILD_SHARED_LIBS=Off -DBUILD_CODEC=Off
