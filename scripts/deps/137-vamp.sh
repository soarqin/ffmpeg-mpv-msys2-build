download_file https://code.soundsoftware.ac.uk/attachments/download/2206/vamp-plugin-sdk-${VAMP_VERSION}.tar.gz
if [ $result == true ]; then return; fi
patch_source vamp-plugin-sdk-${VAMP_VERSION} 137-vamp.patch
SNDFILE_LIBS=-lsndfile compile_with_configure_dirty vamp-plugin-sdk-${VAMP_VERSION} --disable-programs
