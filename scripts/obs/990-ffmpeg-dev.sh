if [ "x${FFMPEG_VERSION}" == "xgit" ]; then
    git_clone https://git.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} master 1
else
    download_file http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2
fi
if [ $any_dirty != true ]; then return; fi
rm -Rf ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
mkdir -p ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
pushd ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
LDFLAGS='-static -static-libgcc -static-libstdc++' ${SRC_ROOT}/ffmpeg-${FFMPEG_VERSION}/configure \
  --prefix=${BUILD_INSTALL_ROOT} \
  --enable-shared \
  --disable-static \
  --pkg-config-flags='--static' \
  --enable-gpl \
  --enable-nonfree \
  --disable-programs \
  --enable-bzlib \
  --enable-iconv \
  --enable-libfdk-aac \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-lzma \
  --enable-nvenc \
  --enable-zlib \
  --disable-debug \
  --disable-postproc
make ${MAKE_JOBS}
make install
popd
