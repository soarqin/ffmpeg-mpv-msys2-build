download_file http://code.breakfastquay.com/attachments/download/34/rubberband-${RUBBERBAND_VERSION}.tar.bz2

if [ "$result" = true ]; then return; fi

#INSTALL LADSPA Plugin Header
curl -LJ http://www.ladspa.org/ladspa_sdk/ladspa.h.txt > ${BUILD_INSTALL_ROOT}/include/ladspa.h

patch_source rubberband-${RUBBERBAND_VERSION} 139-rubberband.patch

compile_with_configure_dirty rubberband-${RUBBERBAND_VERSION}
