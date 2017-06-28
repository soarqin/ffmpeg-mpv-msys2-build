#!/usr/bin/env bash

currdir=$(realpath $(dirname $0))

if [ "x${USE_REPO}" == "x" ]; then
    . $currdir/scripts/version.inc
else
    . $currdir/scripts/version-repo.inc
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
        licdir=$currdir/src/$1
    else
        licdir=$currdir/src/$1-$2
    fi
    if [ ! -d $licdir ]; then
        licdir=$currdir/src/$1_$2/
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

distdir=$currdir/dist
mkdir -p $currdir/package
dpush $currdir/package

echo 'Packaging FFmpeg dev dist...'
pdir=FFmpeg-${FFMPEG_VERSION}-dev-${PACKAGE_SUFFIX}
mkdir -p $pdir
dpush $pdir
mkdir -p bin include lib share license
cp -vf $currdir/src/ffmpeg-${FFMPEG_VERSION}/{README*,RELEASE_NOTES} $(pwd)/
cp -vf $currdir/dist/$ARCH-shared/usr/bin/{*.dll,*.lib} $(pwd)/bin/
cp -vrf $currdir/dist/$ARCH-shared/usr/include/* $(pwd)/include/
cp -vrf $currdir/dist/$ARCH-shared/usr/lib/{pkgconfig,*.a} $(pwd)/lib/
cp -vrf $currdir/dist/$ARCH-shared/usr/share/* $(pwd)/share/
dpush license

cplic ffmpeg ${FFMPEG_VERSION}
cplic zlib ${ZLIB_VERSION}
cplic bzip2 ${BZIP_VERSION}
cplic xz ${XZ_VERSION}
cplic snappy ${SNAPPY_VERSION}
cplic gmp ${GMP_VERSION}
cplic libxml2 ${LIBXML2_VERSION}
cplic fribidi ${FRIBIDI_VERSION}
cplic nettle ${NETTLE_VERSION}
cplic gnutls ${GNUTLS_VERSION}
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
cplic mpg123 ${MPG123_VERSION}
cplic libcaca ${CACA_VERSION}
cplic vid.stab ${VIDSTAB_VERSION}
cplic mfx_dispatch ${MFX_VERSION}
cplic libsndfile ${LIBSNDFILE_VERSION}
cplic libbs2b git
cplic libilbc ${LIBILBC_VERSION}
cplic WavPack ${WAVPACK_VERSION}
cplic game-music-emu ${GME_VERSION}
cplic libass ${LIBASS_VERSION}
cplic libbluray ${LIBBLUERAY_VERSION}
cplic xvidcore
cplic rtmpdump git
cplic libwebp ${WEBP_VERSION}
cplic libvpx ${LIBVPX_VERSION}
cplic openh264 ${OPENH264_VERSION}
cplic x264 git-${X264_BRANCH}
cplic kvazaar ${KVAZAAR_VERSION}
cplic x265 ${X265_VERSION}
cplic libopenmpt ${LIBOPENMPT_VERSION}
cplic libmysofa ${LIBMYSOFA_VERSION}
cplic vamp-plugin-sdk ${VAMP_VERSION}
cplic libsamplerate ${LIBSAMPLERATE_VERSION}
cplic rubberband ${RUBBERBAND_VERSION}
dpop
dpop

dpop
