SRC_ROOT=$(realpath ${SCRIPT_ROOT}/../src)
mkdir -p ${SRC_ROOT}
PATCH_ROOT=$(realpath ${SCRIPT_ROOT}/../patches)

set -e

if [ "x${NO_PKG_INSTALL}" == "x" ]; then
    pacman -Syuq --noconfirm --needed autoconf autogen automake libtool m4 bison flex gzip bzip2 xz tar ca-certificates curl dos2unix doxygen texinfo gettext git mercurial subversion patch gawk glib2 gperf grep info make nasm yasm pkg-config python ${ARCH_PREFIX}toolchain ${ARCH_PREFIX}cmake ${ARCH_PREFIX}python2-lxml ${ARCH_PREFIX}python2-six
fi

cd ${SCRIPT_ROOT}
. env.sh
. util.sh
. compile.sh
