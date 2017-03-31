git_clone git://git.ffmpeg.org/rtmpdump rtmpdump
cd $BUILD_ROOT && mkdir -p rtmpdump && cd rtmpdump
cp -Rf $SRC_ROOT/rtmpdump/librtmp/* .
sed -i -e "s,prefix=/usr/local,prefix=$BUILD_INSTALL_ROOT,g" -e 's,SYS=posix,SYS=mingw,g' -e 's,#CRYPTO=GNUTLS,CRYPTO=GNUTLS,g' Makefile
make $JOBS librtmp.a
make install_base
