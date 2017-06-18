git_clone https://git.ffmpeg.org/rtmpdump.git rtmpdump-git
if [ $result == true ]; then return; fi
patch_source rtmpdump-git 127-rtmpdump.patch
mkdir -p $BUILD_ROOT/librtmp-git
pushd $BUILD_ROOT/librtmp-git
cp -Rf $SRC_ROOT/rtmpdump-git/librtmp/* .
make ${MAKE_JOBS} librtmp.a
prefix=${BUILD_INSTALL_ROOT} make install_base
popd
