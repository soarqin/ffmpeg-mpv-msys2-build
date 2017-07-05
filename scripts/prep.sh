SRC_ROOT=$(realpath -m /ff/src)
DOWNLOAD_ROOT=$(realpath -m /ff/download)
mkdir -p ${SRC_ROOT} ${DOWNLOAD_ROOT}
PATCH_ROOT=$(realpath -m ${SCRIPT_ROOT}/../patches)

set -e

if [ "x${NO_PKG_INSTALL}" == "x" ]; then
    pacman -Syuq --noconfirm --needed autoconf autogen automake libtool m4 bison flex gzip bzip2 xz tar ca-certificates curl dos2unix asciidoc doxygen texinfo gettext git mercurial subversion patch gawk glib2 gperf grep info make pkg-config gyp p7zip ${ARCH_PREFIX}{toolchain,cmake,yasm,nasm,python2-lxml,python2-six}
fi

cd ${SCRIPT_ROOT}
. env.sh
. util.sh
. compile.sh
