if [ "x${FFMPEG_VERSION}" == "xgit" ]; then
    git_clone https://git.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} master 1
else
    download_file http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2
fi
if [ $result == true ]; then return; fi
sed -i -e "/^${fnprefix} /d" "${FINISHED}"

LDFLAGS='-static -static-libgcc -static-libstdc++' compile_with_configure ffmpeg-${FFMPEG_VERSION} \
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
  --enable-libgsm \
  --enable-libilbc \
  --enable-libkvazaar \
  --enable-libmfx \
  --enable-libmp3lame \
  --enable-libopencore-amrnb \
  --enable-libopencore-amrwb \
  --enable-libopenh264 \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libopus \
  --enable-librtmp \
  --enable-librubberband \
  --enable-libschroedinger \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libtheora \
  --enable-libtwolame \
  --enable-libvidstab \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libwavpack \
  --enable-libwebp \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libxavs \
  --enable-libxvid \
  --enable-libzimg \
  --enable-lzma \
  --enable-netcdf \
  --enable-nvenc \
  --enable-zlib
