download_file http://code.breakfastquay.com/attachments/download/34/rubberband-${RUBBERBAND_VERSION}.tar.bz2

if [ "$result" = true ]; then return; fi

patch_source rubberband-${RUBBERBAND_VERSION} 139-rubberband.patch

pushd ${SRC_ROOT}/rubberband-${RUBBERBAND_VERSION}
mkdir lib && touch ./install-sh
autoreconf -if
./configure --prefix=${BUILD_INSTALL_ROOT}
make ${MAKE_JOBS} static && make install
popd
