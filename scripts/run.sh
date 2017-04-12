BUILD_ROOT=$(realpath ${SCRIPT_ROOT}/../build${ARCH})
BUILD_INSTALL_ROOT=$(realpath ${HOME}/mingw${ARCH})
PATCH_ROOT=$(realpath ${SCRIPT_ROOT}/../patches)

set -e

pacman -Syq --noconfirm --needed autoconf autogen automake libtool m4 bison flex gzip bzip2 xz tar ca-certificates curl dos2unix doxygen texinfo gettext git mercurial subversion patch gawk glib2 gperf grep info make nasm yasm pkg-config ${ARCH_PREFIX}toolchain ${ARCH_PREFIX}cmake ${ARCH_PREFIX}python2-lxml ${ARCH_PREFIX}python2-six

mkdir -p ${BUILD_ROOT}

cd ${SCRIPT_ROOT}
. env.sh
mkdir -p ${SRC_ROOT} ${BUILD_INSTALL_ROOT}
. util.sh
. compile.sh
if [ "x${VERSION_FILE}" == "x" ]; then
    . version.inc
else
    . ${VERSION_FILE}
fi

FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi

any_dirty=false
for v in $SCRIPT_ROOT/[0-9][0-9][0-9]-*.sh; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    export -n _lib_revision=""
    . $v
    if [ "x${_lib_revision}" != "x" ]; then
        sed -i -e "/^${fnprefix} /d" "${FINISHED}"
        echo "${_lib_revision}" >> ${FINISHED}
    fi
done
