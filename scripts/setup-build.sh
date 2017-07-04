BUILD_ROOT=$(realpath -m /ff/build/mingw${ARCH}${BUILD_TARGET_SUFFIX}${BUILD_EXTRA_SUFFIX})
BUILD_INSTALL_ROOT=$(realpath -m /ff/install/mingw${ARCH}${BUILD_EXTRA_SUFFIX})
DIST_ROOT=$(realpath -m /ff/dist)
mkdir -p ${BUILD_ROOT} ${BUILD_INSTALL_ROOT}
FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi
