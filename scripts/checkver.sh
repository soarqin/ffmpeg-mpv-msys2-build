#!/usr/bin/env bash

function check_version {
    if [[ $4 =~ ^hg|git|svn$ ]]; then
        echo $1 is skipped due to pulling from $4
        return
    fi
    _content=`curl -LJ $2 2>/dev/null`
    if [[ "${_content}" =~ $3 ]]; then
        newver=${BASH_REMATCH[1]}
        if [ "x$5" != "x" ]; then
            newbeta=${BASH_REMATCH[2]}
            if [ "x${newbeta}" != "x$5" ]; then
                echo $1 $4$5 has new version: ${newver}${newbeta}
                return
            fi
        fi
        if [ "x${newver}" == "x$4" ]; then
            echo $1 $4 is up-to-date
        else
            echo $1 $4 has new version: ${newver}
        fi
    fi
}

set -e

SCRIPT_ROOT=$(realpath $(dirname $0))
if [ "x${VERSION_FILE}" == "x" ]; then
    . ${SCRIPT_ROOT}/version.inc
else
    . ${VERSION_FILE}
fi

check_version zlib 'http://zlib.net' 'Current\ release:[^z]*zlib\ ([0-9\.]+[0-9])' ${ZLIB_VERSION}
check_version bzip2 'http://bzip.org' 'The\ current\ version\ is[^0-9]*([0-9\.]+[0-9])' ${BZIP_VERSION}
check_version XZ 'http://tukaani.org/xz/' '([0-9\.]+[0-9])\ was\ released\ on' ${XZ_VERSION}
check_version Snappy 'https://github.com/google/snappy/releases/latest' 'Snappy\ ([0-9\.]+[0-9])' ${SNAPPY_VERSION}
check_version GMP 'https://gmplib.org' 'gmp-([0-9\.]+[0-9])' ${GMP_VERSION}
check_version libxml2 'http://xmlsoft.org/news.html' 'public\ releases:</p><h3>[^0-9\.]*([0-9\.]+[0-9])' ${LIBXML2_VERSION}
check_version fribidi 'https://fribidi.org' 'fribidi-([0-9\.]+[0-9])' ${FRIBIDI_VERSION}
check_version nettle 'https://ftp.gnu.org/gnu/nettle/?C=M;O=D' 'nettle-([0-9\.]+[0-9])' ${NETTLE_VERSION}
check_version GnuTLS 'http://www.gnutls.org/news.html' 'GnuTLS.([0-9\.]+[0-9])' ${GNUTLS_VERSION}
check_version OpenJPEG 'https://github.com/uclouvain/openjpeg/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${OPENJPEG_VERSION}
check_version libpng 'http://libpng.org/pub/png/libpng.html' 'version:[^\.]+<B>([0-9\.]+[0-9])' ${LIBPNG_VERSION}
check_version FreeType 'https://www.freetype.org' 'FreeType\ ([0-9\.]+[0-9])' ${FREETYPE_VERSION}
check_version FontConfig 'https://www.freedesktop.org/software/fontconfig/release/?C=M;O=D' 'fontconfig-([0-9\.]+[0-9])' ${FONTCONFIG_VERSION}
check_version libjpeg-turbo 'https://github.com/libjpeg-turbo/libjpeg-turbo/releases/latest' 'tag/([0-9\.]+[0-9])' ${LIBJPEG_TURBO_VERSION}
check_version SDL2 'http://www.libsdl.org/download-2.0.php' 'SDL\ version\ ([0-9\.]+[0-9])' ${SDL2_VERSION}
check_version orc 'https://gstreamer.freedesktop.org/src/orc/?C=M;O=D' 'orc-([0-9\.]+[0-9])' ${ORC_VERSION}
check_version fdk-aac 'https://github.com/mstorsjo/fdk-aac/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${FDK_AAC_VERSION}
check_version frei0r 'https://files.dyne.org/frei0r/' 'frei0r-plugins-([0-9\.]+[0-9])' ${FREI0R_VERSION}
check_version z.img 'https://github.com/sekrit-twc/zimg/releases/latest' 'tag\/(release-[0-9\.]+[0-9])' ${ZIMG_VERSION}
check_version libogg 'https://www.xiph.org/downloads/' 'libogg-([0-9\.]+[0-9])' ${OGG_VERSION}
check_version libvorbis 'https://www.xiph.org/downloads/' 'libvorbis-([0-9\.]+[0-9])' ${VORBIS_VERSION}
check_version speex 'https://www.xiph.org/downloads/' 'speex-([0-9\.]+[0-9])' ${SPEEX_VERSION}
check_version libopus 'http://www.opus-codec.org/downloads/' '>libopus\ ([0-9\.]+[0-9])' ${OPUS_VERSION}
check_version twolame 'http://www.twolame.org' 'twolame\ ([0-9\.]+[0-9])' ${TWOLAME_VERSION}
check_version opencore-amr 'https://sourceforge.net/projects/opencore-amr/' 'opencore-amr-([0-9\.]+[0-9])' ${OPENCORE_AMR_VERSION}
check_version mpg123 'https://www.mpg123.de/download.shtml' 'mpg123\ ([0-9\.]+[0-9])' ${MPG123_VERSION}
check_version libcaca 'https://github.com/cacalabs/libcaca/releases/latest' 'tag\/v([0-9\.a-z]+[0-9])' ${CACA_VERSION}
check_version vid.stab 'https://github.com/georgmartius/vid.stab/releases/latest' 'tag\/(release-[0-9\.]+[0-9a-z])' ${VIDSTAB_VERSION}
check_version mfx 'https://github.com/lu-zero/mfx_dispatch/releases/latest' 'tag\/([0-9\.]+[0-9])' ${MFX_VERSION}
check_version libsndfile 'https://github.com/erikd/libsndfile/releases/latest' 'tag\/([0-9\.]+[0-9])' ${LIBSNDFILE_VERSION}
check_version libilbc 'https://github.com/TimothyGu/libilbc/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${LIBILBC_VERSION}
check_version WavPack 'https://github.com/dbry/WavPack/releases/latest' 'tag\/([0-9\.]+[0-9])' ${WAVPACK_VERSION}
check_version libgme 'https://bitbucket.org/mpyne/game-music-emu/downloads/' 'game-music-emu-([0-9\.]+[0-9])' ${GME_VERSION}
check_version libass 'https://github.com/libass/libass/releases/latest' 'tag\/([0-9\.]+[0-9])' ${LIBASS_VERSION}
check_version libbluray 'http://www.videolan.org/developers/libbluray.html' 'libbluray\ ([0-9\.]+[0-9])' ${LIBBLUERAY_VERSION}
check_version xvidcore 'https://labs.xvid.com/source/' 'Xvid\ ([0-9\.]+[0-9])\ stable\ release' ${XVID_VERSION}
check_version libwebp 'https://developers.google.com/speed/webp/download' 'webp\/libwebp-([0-9\.]+[0-9])\.tar\.gz' ${WEBP_VERSION}
check_version libvpx 'https://chromium.googlesource.com/webm/libvpx' '>v([0-9\.]+[0-9])' ${LIBVPX_VERSION}
check_version openh264 'https://github.com/cisco/openh264/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${OPENH264_VERSION}
check_version kvazaar 'https://github.com/ultravideo/kvazaar/releases/latest' 'tag\/([0-9\.]+[0-9])' v${KVAZAAR_VERSION}
check_version x265 'https://bitbucket.org/multicoreware/x265/downloads' 'x265_([0-9\.]+[0-9])' ${X265_VERSION}
check_version libopenmpt 'https://lib.openmpt.org/libopenmpt' '>([0-9\.]+[0-9])-(beta[0-9]+)' ${LIBOPENMPT_VERSION} ${LIBOPENMPT_VERSION_BETA}
check_version netcdf 'https://github.com/Unidata/netcdf-c/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${NETCDF_VERSION}
check_version FFMPEG 'http://ffmpeg.org/download.html' 'ffmpeg-([0-9\.]+[0-9])' ${FFMPEG_VERSION}
check_version uchardet 'https://www.freedesktop.org/wiki/Software/uchardet/' 'uchardet\ version\ ([0-9\.]+[0-9])' ${UCHARDET_VERSION}
check_version libdvdcss 'http://www.videolan.org/developers/libdvdcss.html' 'libdvdcss<\/code> is <b>([0-9\.]+[0-9])' ${DVDCSS_VERSION}
check_version dvdread 'http://www.videolan.org/developers/libdvdnav.html' 'libdvdread<\/code> is <b>([0-9\.]+[0-9])' ${DVDREAD_VERSION}
check_version dvdnav 'http://www.videolan.org/developers/libdvdnav.html' 'libdvdnav<\/code> is <b>([0-9\.]+[0-9])' ${DVDNAV_VERSION}
check_version mpv 'https://github.com/mpv-player/mpv/releases' 'tag\/v([0-9\.]+[0-9])' ${MPV_VERSION}
