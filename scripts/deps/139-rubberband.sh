download_file http://code.breakfastquay.com/attachments/download/34/rubberband-${RUBBERBAND_VERSION}.tar.bz2

if [ $result == true ]; then return; fi

#INSTALL LADSPA Plugin Header
curl -LJ http://www.ladspa.org/ladspa_sdk/ladspa.h.txt > ${BUILD_INSTALL_ROOT}/include/ladspa.h

pushd $SRC_ROOT/rubberband-${RUBBERBAND_VERSION}
if [ ! -f ./patched ]; then
    patch -p1 < ${PATCH_ROOT}/139-rubberband.patch
    touch ./patched
fi
popd

compile_with_configure_dirty rubberband-${RUBBERBAND_VERSION}