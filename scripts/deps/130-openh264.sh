if [ "x${OPENH264_VERSION}" == "xgit" ]; then
    git_clone https://github.com/cisco/openh264 openh264-${OPENH264_VERSION}
else
    download_file https://github.com/cisco/openh264/archive/v${OPENH264_VERSION}.tar.gz openh264-${OPENH264_VERSION}
fi
if [ $result == true ]; then return; fi
mkdir -p $BUILD_ROOT/openh264-${OPENH264_VERSION}
pushd $BUILD_ROOT/openh264-${OPENH264_VERSION}
cp -Rf $SRC_ROOT/openh264-${OPENH264_VERSION}/* .
if [ "x$ARCH" == "x32" ]; then
    E64=Off
fi
sed -i -e "s,PREFIX=/usr/local,PREFIX=$BUILD_INSTALL_ROOT,g" Makefile
sed -i -e 's,x86_64-w64-mingw32-ar,ar,g' build/platform-mingw_nt.mk
ENABLE64BIT=$E64 make ${MAKE_JOBS} install-static install-headers
popd
