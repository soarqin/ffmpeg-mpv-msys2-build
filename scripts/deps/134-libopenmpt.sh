if [ "x${LIBOPENMPT_VERSION}" == "xsvn" ]; then
    svn_checkout https://source.openmpt.org/svn/openmpt/trunk/OpenMPT/ libopenmpt-${LIBOPENMPT_VERSION}
    if [ "$result" = true ]; then return; fi
    patch_source libopenmpt-${LIBOPENMPT_VERSION} 134-libopenmpt-svn.patch
else
    download_file https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-${LIBOPENMPT_VERSION}-${LIBOPENMPT_VERSION_BETA}.tar.gz libopenmpt-${LIBOPENMPT_VERSION}
    if [ "$result" = true ]; then return; fi
    patch_source libopenmpt-${LIBOPENMPT_VERSION} 134-libopenmpt.patch
fi
rm -rf ${BUILD_ROOT}/libopenmpt-${LIBOPENMPT_VERSION}
mkdir -p ${BUILD_ROOT}/libopenmpt-${LIBOPENMPT_VERSION}
pushd ${BUILD_ROOT}/libopenmpt-${LIBOPENMPT_VERSION}
cp -Rf ${SRC_ROOT}/libopenmpt-${LIBOPENMPT_VERSION}/* .
make PREFIX=${BUILD_INSTALL_ROOT} AR=ar CONFIG=mingw64-win${ARCH} STATIC_LIB=1 SHARED_LIB=0 DYNLINK=0 EXAMPLES=0 OPENMPT123=0 TEST=0 NO_ZLIB=0 NO_MPG123=0 NO_OGG=0 NO_VORBIS=0 NO_VORBISFILE=1 NO_PORTAUDIO=1 NO_PORTAUDIOCPP=1 NO_PULSEAUDIO=1 NO_SDL=1 NO_SDL2=0 NO_SNDFILE=0 NO_FLAC=1 NO_STBVORBIS=1 ${MAKE_JOBS}
make PREFIX=${BUILD_INSTALL_ROOT} AR=ar CONFIG=mingw64-win${ARCH} STATIC_LIB=1 SHARED_LIB=0 DYNLINK=0 EXAMPLES=0 OPENMPT123=0 TEST=0 NO_ZLIB=0 NO_MPG123=0 NO_OGG=0 NO_VORBIS=0 NO_VORBISFILE=1 NO_PORTAUDIO=1 NO_PORTAUDIOCPP=1 NO_PULSEAUDIO=1 NO_SDL=1 NO_SDL2=0 NO_SNDFILE=0 NO_FLAC=1 NO_STBVORBIS=1 install
popd
