if [ "x${FFMPEG_VERSION}" == "xgit" ]; then
    git_clone https://git.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} master 1
    FFMPEG_EXTRA_FLAGS=--enable-libmysofa
else
    download_file http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2
fi
if [ "$any_dirty" != true ]; then return; fi
sed -i -e "/^${fnprefix} /d" "${FINISHED}"

rm -Rf ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
mkdir -p ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
pushd ${BUILD_ROOT}/ffmpeg-${FFMPEG_VERSION}
LDFLAGS='-static -static-libgcc -static-libstdc++' ${SRC_ROOT}/ffmpeg-${FFMPEG_VERSION}/configure \
  --prefix=$(realpath -m ${SCRIPT_ROOT}/../dist/${ARCH}_mpv${BUILD_EXTRA_SUFFIX}) \
  --enable-static \
  --disable-shared \
  --pkg-config-flags='--static' \
  --enable-gpl \
  --enable-version3 \
  --disable-programs \
  --disable-encoders \
  --disable-muxers \
  --disable-doc \
  --enable-avisynth \
  --enable-avresample \
  --enable-bzlib \
  --enable-cuda \
  --enable-cuvid \
  --enable-d3d11va \
  --enable-dxva2 \
  --enable-fontconfig \
  --enable-frei0r \
  --enable-gmp \
  --enable-gnutls \
  --enable-iconv \
  --enable-libass \
  --enable-libbluray \
  --enable-libbs2b \
  --enable-libcaca \
  --enable-libfreetype \
  --enable-libfribidi \
  --enable-libgme \
  --enable-libilbc \
  --enable-libmfx \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-librtmp \
  --enable-librubberband \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libvidstab \
  --enable-libzimg \
  --enable-lzma \
  --enable-nvenc \
  --enable-schannel \
  --enable-zlib \
  ${FFMPEG_EXTRA_FLAGS}
make ${MAKE_JOBS}
make install
popd
