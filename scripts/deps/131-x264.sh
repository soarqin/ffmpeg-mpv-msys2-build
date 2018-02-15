git_clone http://git.videolan.org/git/x264.git x264-git-${X264_BRANCH} ${X264_BRANCH}
if [ "$result" = true ]; then return; fi
if [ "x$ARCH" == "x32" ]; then
    ECFLAGS="--host=i686-w64-mingw32"
fi
rm -rf ${BUILD_ROOT}/x264-git-${X264_BRANCH}
compile_with_configure x264-git-${X264_BRANCH} --enable-static --disable-cli --bit-depth=all --enable-pic $ECFLAGS
