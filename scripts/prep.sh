if [ "x${USE_REPO}" == "x" ]; then
    . ${SCRIPT_ROOT}/version.inc
else
    . ${SCRIPT_ROOT}/version-repo.inc
fi

case `gcc -dumpmachine` in
    x86_64-w64-mingw32)
        ARCH=64
        ARCH_PREFIX=mingw-w64-x86_64-
        ;;
    i686-w64-mingw32)
        ARCH=32
        ARCH_PREFIX=mingw-w64-i686-
        ;;
esac

BUILD_ROOT=$(realpath ${SCRIPT_ROOT}/../build${ARCH}${BUILD_TARGET_SUFFIX}${BUILD_EXTRA_SUFFIX})
BUILD_INSTALL_ROOT=$(realpath ${HOME}/mingw${ARCH}${BUILD_EXTRA_SUFFIX})
PATCH_ROOT=$(realpath ${SCRIPT_ROOT}/../patches)

set -e

if [ "x${NO_PKG_INSTALL}" == "x" ]; then
    pacman -Syq --noconfirm --needed autoconf autogen automake libtool m4 bison flex gzip bzip2 xz tar ca-certificates curl dos2unix doxygen texinfo gettext git mercurial subversion patch gawk glib2 gperf grep info make nasm yasm pkg-config python ${ARCH_PREFIX}toolchain ${ARCH_PREFIX}cmake ${ARCH_PREFIX}python2-lxml ${ARCH_PREFIX}python2-six
fi

mkdir -p ${BUILD_ROOT}

cd ${SCRIPT_ROOT}
. env.sh
mkdir -p ${SRC_ROOT} ${BUILD_INSTALL_ROOT}
. util.sh
. compile.sh

FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi
