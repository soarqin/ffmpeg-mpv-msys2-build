git_clone https://git.ffmpeg.org/rtmpdump.git rtmpdump-git
if [ $result == true ]; then return; fi
mkdir -p $BUILD_ROOT/librtmp-git
pushd $BUILD_ROOT/librtmp-git
cp -Rf $SRC_ROOT/rtmpdump-git/librtmp/* .
sed -i -e "s,prefix=/usr/local,prefix=$BUILD_INSTALL_ROOT,g" -e 's,SYS=posix,SYS=mingw,g' -e 's,#CRYPTO=GNUTLS,CRYPTO=GNUTLS,g' Makefile
make $JOBS librtmp.a
make install_base
popd
