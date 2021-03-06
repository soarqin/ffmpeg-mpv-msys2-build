#!/usr/bin/env bash

function check_version {
    if [[ $4 =~ ^hg|git|svn$ ]]; then
        echo "[SKIPPED] $1 is skipped due to pulling from $4"
        return
    fi
    _content=`curl -LJ $2 2>/dev/null`
    if [[ "${_content}" =~ $3 ]]; then
        newver=${BASH_REMATCH[1]}
        if [ "x$5" != "x" ]; then
            newbeta=${BASH_REMATCH[2]}
            if [ "x${newbeta}" != "x$5" ]; then
                echo "!!NEW VERSION!! $1 $4$5 has new version: ${newver}${newbeta}"
                return
            fi
        fi
        if [ "x${newver}" == "x$4" ]; then
            echo "[UP-TO-DATE] $1 $4$5"
        else
            echo "!!NEW VERSION!! $1 $4 has new version: ${newver}"
        fi
    else
        echo "!!ERROR!! Cannot check update for $1 $4$5"
    fi
}

set -e

SCRIPT_ROOT=$(realpath $(dirname $0))/scripts
if [ "x${USE_REPO}" == "x" ]; then
    . ${SCRIPT_ROOT}/version.inc
else
    . ${SCRIPT_ROOT}/version-repo.inc
fi

check_version zlib 'http://zlib.net' 'Current\ release:[^z]*zlib\ ([0-9\.]+[0-9])' ${ZLIB_VERSION}
check_version bzip2 'http://bzip.org' 'The\ current\ version\ is[^0-9]*([0-9\.]+[0-9])' ${BZIP_VERSION}
check_version XZ 'http://tukaani.org/xz/' '([0-9\.]+[0-9])\ was\ released\ on' ${XZ_VERSION}
check_version Snappy 'https://github.com/google/snappy/releases/latest' 'Snappy\ ([0-9\.]+[0-9])' ${SNAPPY_VERSION}
check_version libxml2 'http://xmlsoft.org/news.html' 'public\ releases:</p><h3>[^0-9\.]*([0-9\.]+[0-9])' ${LIBXML2_VERSION}
check_version fribidi 'https://fribidi.org' 'fribidi-([0-9\.]+[0-9])' ${FRIBIDI_VERSION}
check_version libgpg-error 'https://www.gnupg.org/download/index.html' 'Libgpg-error[^0-9]*([0-9\.]+[0-9])' ${LIBGPG_ERROR_VERSION}
check_version libgcryto 'https://www.gnupg.org/download/index.html' 'Libgcrypt[^0-9]*([0-9\.]+[0-9])' ${LIBGCRYPT_VERSION}
check_version fftw 'http://www.fftw.org/download.html' 'fftw-(([0-9]+\.)+[0-9](-pl[0-9])?)' ${FFTW_VERSION}
check_version OpenJPEG 'https://github.com/uclouvain/openjpeg/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${OPENJPEG_VERSION}
check_version libpng 'http://libpng.org/pub/png/libpng.html' 'version:[^\.]+<B>([0-9\.]+[0-9])' ${LIBPNG_VERSION}
check_version graphite2 'https://github.com/silnrsi/graphite/releases/latest' 'tag\/([0-9\.]+[0-9])' ${GRAPHITE2_VERSION}
check_version FreeType 'https://www.freetype.org' 'FreeType\ ([0-9\.]+[0-9])' ${FREETYPE_VERSION}
check_version FontConfig 'https://www.freedesktop.org/software/fontconfig/release/?C=M;O=D' 'fontconfig-([0-9\.]+[0-9])' ${FONTCONFIG_VERSION}
check_version HarfBuzz 'https://www.freedesktop.org/software/harfbuzz/release/?C=M;O=D' 'harfbuzz-([0-9\.]+[0-9])\.tar\.bz2' ${HARFBUZZ_VERSION}
check_version SDL2 'http://www.libsdl.org/download-2.0.php' 'SDL\ version\ ([0-9\.]+[0-9])' ${SDL2_VERSION}
check_version fdk-aac 'https://github.com/mstorsjo/fdk-aac/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${FDK_AAC_VERSION}
check_version frei0r 'https://files.dyne.org/frei0r/' 'frei0r-plugins-([0-9\.]+[0-9])' ${FREI0R_VERSION}
check_version z.img 'https://github.com/sekrit-twc/zimg/releases/latest' 'tag\/(release-[0-9\.]+[0-9])' ${ZIMG_VERSION}
check_version libogg 'https://www.xiph.org/downloads/' 'libogg-([0-9\.]+[0-9])' ${OGG_VERSION}
check_version libvorbis 'https://www.xiph.org/downloads/' 'libvorbis-([0-9\.]+[0-9])' ${VORBIS_VERSION}
check_version libtheora 'https://www.xiph.org/downloads/' 'libtheora-([0-9\.]+[0-9])' ${THEORA_VERSION}
check_version speex 'https://www.xiph.org/downloads/' 'speex-([0-9\.]+[0-9])' ${SPEEX_VERSION}
check_version libopus 'http://www.opus-codec.org/downloads/' '>libopus\ ([0-9\.]+[0-9])' ${OPUS_VERSION}
check_version twolame 'http://www.twolame.org' 'twolame\ ([0-9\.]+[0-9])' ${TWOLAME_VERSION}
check_version opencore-amr 'https://sourceforge.net/projects/opencore-amr/' 'opencore-amr-([0-9\.]+[0-9])' ${OPENCORE_AMR_VERSION}
check_version libcaca 'https://github.com/cacalabs/libcaca/releases/latest' 'tag\/v([0-9\.a-z]+[0-9])' ${CACA_VERSION}
check_version vid.stab 'https://github.com/georgmartius/vid.stab/releases/latest' 'tag\/(release-[0-9\.]+[0-9a-z])' ${VIDSTAB_VERSION}
check_version mfx 'https://github.com/lu-zero/mfx_dispatch/releases/latest' 'tag\/([0-9\.]+[0-9])' ${MFX_VERSION}
check_version libass 'https://github.com/libass/libass/releases/latest' 'tag\/([0-9\.]+[0-9])' ${LIBASS_VERSION}
check_version WavPack 'https://github.com/dbry/WavPack/releases/latest' 'tag\/([0-9\.]+[0-9])' ${WAVPACK_VERSION}
check_version libilbc 'https://github.com/TimothyGu/libilbc/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${LIBILBC_VERSION}
check_version libgme 'https://bitbucket.org/mpyne/game-music-emu/downloads/' 'game-music-emu-([0-9\.]+[0-9])' ${GME_VERSION}
check_version libaacs 'http://www.videolan.org/developers/libaacs.html' 'libaacs\ ([0-9\.]+[0-9])' ${LIBAACS_VERSION}
check_version libbdplus 'http://www.videolan.org/developers/libbdplus.html' 'libbdplus\ ([0-9\.]+[0-9])' ${LIBBDPLUS_VERSION}
check_version libbluray 'http://www.videolan.org/developers/libbluray.html' 'libbluray\ ([0-9\.]+[0-9])' ${LIBBLURAY_VERSION}
check_version xvidcore 'https://labs.xvid.com/source/' 'Xvid\ ([0-9\.]+[0-9])\ stable\ release' ${XVID_VERSION}
check_version libwebp 'https://developers.google.com/speed/webp/download' 'webp\/libwebp-([0-9\.]+[0-9])\.tar\.gz' ${WEBP_VERSION}
check_version libvpx 'https://chromium.googlesource.com/webm/libvpx' '>v([0-9\.]+[0-9])' ${LIBVPX_VERSION}
check_version openh264 'https://github.com/cisco/openh264/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${OPENH264_VERSION}
check_version kvazaar 'https://github.com/ultravideo/kvazaar/releases/latest' 'tag\/(v[0-9\.]+[0-9])' v${KVAZAAR_VERSION}
check_version x265 'https://bitbucket.org/multicoreware/x265/downloads' 'x265_([0-9\.]+[0-9])' ${X265_VERSION}
check_version libopenmpt 'https://lib.openmpt.org/libopenmpt/download/' '>([0-9\.]+[0-9])-(beta[0-9]+)' ${LIBOPENMPT_VERSION} ${LIBOPENMPT_VERSION_BETA}
check_version libmysofa 'https://github.com/hoene/libmysofa/releases/latest' 'tag\/v([0-9\.,]+[0-9])' ${LIBMYSOFA_VERSION}
check_version rubberband 'http://breakfastquay.com/rubberband/' 'Rubber Band Library v([0-9\.]+[0-9])' ${RUBBERBAND_VERSION}
check_version FFmpeg 'http://ffmpeg.org/download.html' 'ffmpeg-([0-9\.]+[0-9])' ${FFMPEG_VERSION}
check_version lzo 'http://www.oberhumer.com/opensource/lzo/' 'Version ([0-9\.]+[0-9])' ${LZO_VERSION}
check_version libarchive 'https://github.com/libarchive/libarchive/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${LIBARCHIVE_VERSION}
check_version libjpeg-turbo 'https://github.com/libjpeg-turbo/libjpeg-turbo/releases/latest' 'tag/([0-9\.]+[0-9])' ${LIBJPEG_TURBO_VERSION}
check_version libffi 'https://github.com/libffi/libffi/releases/latest' 'tag\/v([0-9\.]+[0-9])' ${LIBFFI_VERSION}
check_version LuaJIT 'http://luajit.org/download.html' 'LuaJIT-([0-9\.]+[0-9]-[a-z]+[0-9])' ${LUAJIT_VERSION}
check_version lcms2 'http://www.littlecms.com/download.html' 'Current version is ([0-9\.]+[0-9])' ${LCMS2_VERSION}
check_version Python 'https://www.python.org/downloads/source/' 'Latest\ Python\ 3\ Release\ -\ Python\ ([0-9\.]+[0-9])' ${PYTHON_VERSION}
check_version vapoursynth 'https://github.com/vapoursynth/vapoursynth/releases/latest' 'Release\ ([A-Z][0-9]+)' ${VAPOURSYNTH_VERSION}
check_version uchardet 'https://www.freedesktop.org/wiki/Software/uchardet/' 'uchardet\ version\ ([0-9\.]+[0-9])' ${UCHARDET_VERSION}
check_version dvdcss 'http://www.videolan.org/developers/libdvdcss.html' 'libdvdcss<\/code> is <b>([0-9\.]+[0-9])' ${DVDCSS_VERSION}
check_version dvdread 'http://www.videolan.org/developers/libdvdnav.html' 'libdvdread<\/code> is <b>([0-9\.]+[0-9])' ${DVDREAD_VERSION}
check_version dvdnav 'http://www.videolan.org/developers/libdvdnav.html' 'libdvdnav<\/code> is <b>([0-9\.]+[0-9])' ${DVDNAV_VERSION}
check_version mpv 'https://github.com/mpv-player/mpv/releases' 'tag\/v([0-9\.]+[0-9])' ${MPV_VERSION}
check_version curl 'https://curl.haxx.se/download.html' 'curl ([0-9\.a-z]+[0-9])' ${CURL_VERSION}
check_version speexdsp 'https://speex.org/downloads/' 'SpeexDSP ([0-9\.a-z]+[0-9])' ${SPEEXDSP_VERSION}
