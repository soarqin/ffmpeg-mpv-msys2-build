if [ "x${FFMPEG_VERSION}" == "xgit" ]; then
    git_clone https://git.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} master 1
    FFMPEG_EXTRA_FLAGS="--enable-cuda --enable-cuvid"
else
    download_file http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2
fi
if [ $any_dirty != true ]; then return; fi

LDFLAGS='-static -static-libgcc -static-libstdc++' compile_with_configure ffmpeg-${FFMPEG_VERSION} \
  --enable-static \
  --disable-shared \
  --pkg-config-flags='--static' \
  --enable-gpl \
  --enable-version3 \
  --enable-nonfree \
  --enable-iconv \
  --enable-d3d11va \
  --enable-dxva2 \
  --enable-libmfx \
  --enable-nvenc \
  --enable-avisynth \
  --enable-bzlib \
  --enable-fontconfig \
  --enable-frei0r \
  --enable-gnutls \
  --enable-libass \
  --enable-libbluray \
  --enable-libbs2b \
  --enable-libcaca \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libgme \
  --enable-libgsm \
  --enable-libilbc \
  --enable-libkvazaar \
  --enable-libmp3lame \
  --enable-libopencore-amrnb \
  --enable-libopencore-amrwb \
  --enable-libopenh264 \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libopus \
  --enable-librtmp \
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
  --enable-zlib \
  ${FFMPEG_EXTRA_FLAGS}
