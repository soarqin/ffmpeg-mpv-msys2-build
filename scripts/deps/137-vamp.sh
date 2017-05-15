download_file https://code.soundsoftware.ac.uk/attachments/download/2206/vamp-plugin-sdk-${VAMP_VERSION}.tar.gz
if [ $result == true ]; then return; fi
pushd $SRC_ROOT/vamp-plugin-sdk-${VAMP_VERSION}
if [ ! -f ./patched ]; then
    patch -p1 < ${PATCH_ROOT}/137-vamp.patch
    touch ./patched
fi
popd
SNDFILE_LIBS=-lsndfile compile_with_configure_dirty vamp-plugin-sdk-${VAMP_VERSION} --disable-programs
