git_clone https://github.com/cisco/openh264 openh264
cd $BUILD_ROOT && mkdir -p openh264 && cd openh264
cp -Rf $SRC_ROOT/openh264/* .
sed -i -e "s,PREFIX=/usr/local,PREFIX=$BUILD_INSTALL_ROOT,g" Makefile
sed -i -e 's,x86_64-w64-mingw32-ar,ar,g' build/platform-mingw_nt.mk
make $JOBS install-static install-headers
