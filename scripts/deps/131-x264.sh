git_clone http://git.videolan.org/git/x264.git x264-git ${X264_BRANCH}
if [ $result == true ]; then return; fi
if [ "x$ARCH" == "x32" ]; then
    ECFLAGS="--host=i686-w64-mingw32"
fi
compile_with_configure x264-git --enable-static --disable-cli --enable-pic $ECFLAGS
