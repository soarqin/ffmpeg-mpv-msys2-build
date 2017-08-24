#!/usr/bin/env bash

currdir=$(realpath $(dirname $0))

if [ "x${USE_REPO}" == "x" ]; then
    . $currdir/scripts/version.inc
    DIR_SUFFIX=
else
    . $currdir/scripts/version-repo.inc
    DIR_SUFFIX=_repo
fi

case `gcc -dumpmachine` in
    x86_64-w64-mingw32)
        ARCH=64
        ARCH_PREFIX=mingw-w64-x86_64-
        PACKAGE_SUFFIX=x86_64
        ;;
    i686-w64-mingw32)
        ARCH=32
        ARCH_PREFIX=mingw-w64-i686-
        PACKAGE_SUFFIX=i686
        ;;
esac

function dpush {
    pushd $1 >/dev/null 2>&1
}
function dpop {
    popd >/dev/null 2>&1
}
function cplic {
    if [ "x$2" == "x" ]; then
        licdir=$srcdir/$1
    else
        licdir=$srcdir/$1-$2
    fi
    if [ ! -d $licdir ]; then
        licdir=$srcdir/$1_$2/
        if [ ! -d $licdir ]; then
            echo $1" "$2" not found"
            return
        fi
    fi
    files=($licdir/{LICENSE,license}*)
    found=false
    if [ ${#files[@]} -gt 0 ]; then
        mkdir -p $1
        cp -vf $licdir/{LICENSE,license}* $(pwd)/$1/
        found=true
    fi
    files=($licdir/{COPYING,copying}*)
    if [ ${#files[@]} -gt 0 ]; then
        mkdir -p $1
        cp -vf $licdir/{COPYING,copying}* $(pwd)/$1/
        found=true
    fi
    if [ "$found" != true ]; then
        files=($licdir/{README,readme}*)
        if [ ${#files[@]} -gt 0 ]; then
                mkdir -p $1
            cp -vf $licdir/{README,readme}* $(pwd)/$1/
            found=true
        fi
    fi
    if [ "$found" != true ]; then
        echo "No license file found for "$1
    fi
}

shopt -s nullglob

distdir=/ff/dist
srcdir=/ff/src
installdir=/ff/install/mingw${ARCH}${DIR_SUFFIX}

mkdir -p /ff/package
dpush /ff/package

pdir_dev=FFmpeg-${FFMPEG_VERSION}-dev-${PACKAGE_SUFFIX}
pdir_shared=FFmpeg-${FFMPEG_VERSION}-shared-${PACKAGE_SUFFIX}
pdir_static=FFmpeg-${FFMPEG_VERSION}-static-${PACKAGE_SUFFIX}
pdir_mpv=mpv-${MPV_VERSION}-${PACKAGE_SUFFIX}
pdir_fdk_aac=fdk-aac-${FDK_AAC_VERSION}-${PACKAGE_SUFFIX}
pdir_x264_10bit=x264_10bit-${X264_BRANCH}-${PACKAGE_SUFFIX}

echo 'Packaging FFmpeg dev dist...'
mkdir -p $pdir_dev
dpush $pdir_dev
mkdir -p bin include lib share license
cp -vf $srcdir/ffmpeg-${FFMPEG_VERSION}/{README*,RELEASE*} $(pwd)/
cp -vf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/bin/{*.dll,*.lib} $(pwd)/bin/
cp -vf $installdir/bin/libx264*.dll $(pwd)/bin/
cp -vrf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/include/* $(pwd)/include/
cp -vrf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/lib/{pkgconfig,*.a} $(pwd)/lib/
cp -vrf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/share/* $(pwd)/share/
dpush license
cplic ffmpeg ${FFMPEG_VERSION}
cplic zlib ${ZLIB_VERSION}
cplic bzip2 ${BZIP_VERSION}
cplic xz ${XZ_VERSION}
cplic snappy ${SNAPPY_VERSION}
cplic libxml2 ${LIBXML2_VERSION}
cplic fribidi ${FRIBIDI_VERSION}
cplic fftw ${FFTW_VERSION}
cplic openjpeg ${OPENJPEG_VERSION}
cplic libpng ${LIBPNG_VERSION}
cplic freetype ${FREETYPE_VERSION}
cplic fontconfig ${FONTCONFIG_VERSION}
cplic harfbuzz ${HARFBUZZ_VERSION}
cplic SDL2 ${SDL2_VERSION}
cplic fdk-aac ${FDK_AAC_VERSION}
cplic frei0r-plugins ${FREI0R_VERSION}
cplic gsm '1.0-pl13'
cplic zimg ${ZIMG_VERSION}
cplic xavs
cplic libogg ${OGG_VERSION}
cplic libvorbis ${VORBIS_VERSION}
cplic libtheora ${THEORA_VERSION}
cplic speex ${SPEEX_VERSION}
cplic opus ${OPUS_VERSION}
cplic lame ${LAME_VERSION}
cplic twolame ${TWOLAME_VERSION}
cplic soxr git
cplic opencore-amr ${OPENCORE_AMR_VERSION}
cplic libcaca ${CACA_VERSION}
cplic vid.stab ${VIDSTAB_VERSION}
cplic mfx_dispatch ${MFX_VERSION}
cplic libbs2b git
cplic libilbc ${LIBILBC_VERSION}
cplic WavPack ${WAVPACK_VERSION}
cplic game-music-emu ${GME_VERSION}
cplic libass ${LIBASS_VERSION}
cplic libbluray ${LIBBLUERAY_VERSION}
cplic xvidcore
cplic libwebp ${WEBP_VERSION}
cplic libvpx ${LIBVPX_VERSION}
cplic openh264 ${OPENH264_VERSION}
cplic x264 git-${X264_BRANCH}
cplic kvazaar ${KVAZAAR_VERSION}
cplic x265 ${X265_VERSION}
cplic libopenmpt ${LIBOPENMPT_VERSION}
cplic libmysofa ${LIBMYSOFA_VERSION}
cplic rubberband ${RUBBERBAND_VERSION}
dpop
dpop

echo 'Packaging FFmpeg shared dist...'
mkdir -p $pdir_shared
dpush $pdir_shared
mkdir -p bin share license
cp -vf $srcdir/ffmpeg-${FFMPEG_VERSION}/{README*,RELEASE*} $(pwd)/
cp -vf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/bin/{*.dll,*.exe} $(pwd)/bin/
cp -vf $installdir/bin/libx264*.dll $(pwd)/bin/
cp -vrf $distdir/${ARCH}-shared${DIR_SUFFIX}/usr/share/* $(pwd)/share/
cp -vrf ../$pdir_dev/license/* $(pwd)/license/
dpop

echo 'Packaging FFmpeg static dist...'
mkdir -p $pdir_static
dpush $pdir_static
mkdir -p bin share license
cp -vf $srcdir/ffmpeg-${FFMPEG_VERSION}/{README*,RELEASE*} $(pwd)/
cp -vf $distdir/${ARCH}-static${DIR_SUFFIX}/usr/bin/{*.dll,*.exe} $(pwd)/bin/
cp -vf $installdir/bin/libx264*.dll $(pwd)/bin/
cp -vrf $distdir/${ARCH}-static${DIR_SUFFIX}/usr/share/* $(pwd)/share/
cp -vrf ../$pdir_dev/license/* $(pwd)/license/
dpop

echo 'Packaging mpv...'
mkdir -p $pdir_mpv
dpush $pdir_mpv
mkdir -p mpv
cp -vf $srcdir/mpv-${MPV_VERSION}/{README*,RELEASE*} $(pwd)/
cp -vf $distdir/${ARCH}_mpv${DIR_SUFFIX}/{etc,share/doc}/mpv/* $(pwd)/mpv/
cp -vf $distdir/${ARCH}_mpv${DIR_SUFFIX}/bin/mpv.* $(pwd)/
cp -vf $installdir/bin/libpython*.dll $(pwd)/
cp -vf $installdir/bin/libaacs*.dll $(pwd)/libaacs.dll
cp -vf $installdir/bin/libbdplus*.dll $(pwd)/libbdplus.dll
chmod 0755 ./*.{exe,dll}
strip ./*.{exe,dll}
mkdir -p license
dpush license
cplic ffmpeg ${FFMPEG_VERSION}
cplic zlib ${ZLIB_VERSION}
cplic bzip2 ${BZIP_VERSION}
cplic xz ${XZ_VERSION}
cplic snappy ${SNAPPY_VERSION}
cplic libxml2 ${LIBXML2_VERSION}
cplic fribidi ${FRIBIDI_VERSION}
cplic fftw ${FFTW_VERSION}
cplic openjpeg ${OPENJPEG_VERSION}
cplic libpng ${LIBPNG_VERSION}
cplic freetype ${FREETYPE_VERSION}
cplic fontconfig ${FONTCONFIG_VERSION}
cplic harfbuzz ${HARFBUZZ_VERSION}
cplic frei0r-plugins ${FREI0R_VERSION}
cplic zimg ${ZIMG_VERSION}
cplic speex ${SPEEX_VERSION}
cplic soxr git
cplic libcaca ${CACA_VERSION}
cplic vid.stab ${VIDSTAB_VERSION}
cplic mfx_dispatch ${MFX_VERSION}
cplic libbs2b git
cplic libilbc ${LIBILBC_VERSION}
cplic game-music-emu ${GME_VERSION}
cplic libass ${LIBASS_VERSION}
cplic libbluray ${LIBBLUERAY_VERSION}
cplic libaacs ${LIBAACS_VERSION}
cplic libbdplus ${LIBBDPLUS_VERSION}
cplic rtmpdump git
cplic libopenmpt ${LIBOPENMPT_VERSION}
cplic libmysofa ${LIBMYSOFA_VERSION}
cplic rubberband ${RUBBERBAND_VERSION}
cplic libarchive ${LIBARCHIVE_VERSION}
cplic libffi ${LIBFFI_VERSION}
cplic uchardet ${UCHARDET_VERSION}
cplic angle git
cplic LuaJIT ${LUAJIT_VERSION}
cplic mujs git
cplic Python ${PYTHON_VERSION}
cplic lcms2 ${LCMS2_VERSION}
cplic cython git
cplic vapoursynth ${VAPOURSYNTH_VERSION}
cplic libdvdcss ${DVDCSS_VERSION}
cplic libdvdread ${DVDREAD_VERSION}
cplic libdvdnav ${DVDNAV_VERSION}
cplic mpv ${MPV_VERSION}
dpop
dpop

mkdir -p $pdir_fdk_aac
dpush $pdir_fdk_aac
cp -vf $installdir/bin/libfdk-aac*.dll $(pwd)/
cp -vf $srcdir/fdk-aac-${FDK_AAC_VERSION}/NOTICE $(pwd)/
dpop

mkdir -p $pdir_x264_10bit
dpush $pdir_x264_10bit
cp -vf $distdir/${ARCH}_x264-10bit${DIR_SUFFIX}/usr/bin/libx264*.dll $(pwd)/
cp -vf $srcdir/x264-git-${X264_BRANCH}/COPYING $(pwd)/
dpop

for n in $pdir_dev $pdir_shared $pdir_static $pdir_mpv $pdir_fdk_aac $pdir_x264_10bit; do
    rm -f $n.7z
    dpush $n
    7z a -mx=9 ../$n.7z
    dpop
done

dpop
