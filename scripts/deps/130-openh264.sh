if [ "x${OPENH264_VERSION}" == "xgit" ]; then
    git_clone https://github.com/cisco/openh264 openh264-${OPENH264_VERSION}
else
    download_file https://github.com/cisco/openh264/archive/v${OPENH264_VERSION}.tar.gz openh264-${OPENH264_VERSION}
fi
if [ $result == true ]; then return; fi
patch_source openh264-${OPENH264_VERSION} 130-openh264.patch 1
mkdir -p ${BUILD_ROOT}/openh264-${OPENH264_VERSION}
pushd ${BUILD_ROOT}/openh264-${OPENH264_VERSION}
cp -Rf ${SRC_ROOT}/openh264-${OPENH264_VERSION}/* .
if [ "x$ARCH" == "x32" ]; then
    E64=Off
fi
PREFIX=${BUILD_INSTALL_ROOT} ENABLE64BIT=$E64 make ${MAKE_JOBS} install-static install-headers
popd
