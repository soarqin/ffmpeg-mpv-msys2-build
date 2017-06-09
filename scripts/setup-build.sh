BUILD_ROOT=$(realpath -m ${SCRIPT_ROOT}/../build${ARCH}${BUILD_TARGET_SUFFIX}${BUILD_EXTRA_SUFFIX})
BUILD_INSTALL_ROOT=$(realpath -m ${HOME}/mingw${ARCH}${BUILD_EXTRA_SUFFIX})
mkdir -p ${BUILD_ROOT} ${BUILD_INSTALL_ROOT}
FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi
