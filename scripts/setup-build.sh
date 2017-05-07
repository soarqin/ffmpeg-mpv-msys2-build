BUILD_ROOT=$(realpath ${SCRIPT_ROOT}/../build${ARCH}${BUILD_TARGET_SUFFIX}${BUILD_EXTRA_SUFFIX})
mkdir -p ${BUILD_ROOT}
FINISHED=${BUILD_ROOT}/finished
if [ ! -f ${FINISHED} ]; then
    touch ${FINISHED}
fi
