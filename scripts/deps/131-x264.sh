git_clone http://git.videolan.org/git/x264.git x264-git-${X264_BRANCH} ${X264_BRANCH}
if [ "$result" = true ]; then return; fi
if [ "x$ARCH" == "x32" ]; then
    ECFLAGS="--host=i686-w64-mingw32"
fi
patch_source x264-git-${X264_BRANCH} 131-x264.patch
rm -rf ${BUILD_ROOT}/x264-git-${X264_BRANCH}
mkdir -p ${BUILD_ROOT}/x264-git-${X264_BRANCH}
pushd ${BUILD_ROOT}/x264-git-${X264_BRANCH}
${SRC_ROOT}/x264-git-${X264_BRANCH}/configure --prefix=/usr --enable-shared --disable-cli --bit-depth=10 --enable-pic $ECFLAGS
make ${MAKE_JOBS}
dstdir=$(realpath -m ${SCRIPT_ROOT}/../dist/${ARCH}_x264-10bit${BUILD_EXTRA_SUFFIX})
rm -f ${dstdir}/usr/bin/libx264-*.dll
make install DESTDIR=${dstdir}
popd
rm -f ${BUILD_INSTALL_ROOT}/bin/libx264-*.dll
compile_with_configure x264-git-${X264_BRANCH} --enable-shared --disable-cli --enable-pic $ECFLAGS
pushd ${BUILD_INSTALL_ROOT}/lib
cp -f libx264.dll.a libx264.a
popd
