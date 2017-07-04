BUILD_ROOT=$(realpath -m /ff/build/obs${ARCH}${BUILD_TARGET_SUFFIX}${BUILD_EXTRA_SUFFIX})
BUILD_INSTALL_ROOT=$(realpath -m /ff/install/obs${ARCH}${BUILD_EXTRA_SUFFIX})
mkdir -p ${BUILD_ROOT} ${BUILD_INSTALL_ROOT}
FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi
