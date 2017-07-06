BUILD_TARGET_SUFFIX=
. ${SCRIPT_ROOT}/setup.sh
. ${SCRIPT_ROOT}/setup-build.sh
. ${SCRIPT_ROOT}/prep.sh

any_dirty=false
. ${SCRIPT_ROOT}/run-deps.sh
declare -a components=()
load_components 'ffmpeg'
for v in ${components[@]}; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    export -n _lib_revision=""
    . $v
    if [ "x${_lib_revision}" != "x" ]; then
        sed -i -e "/^${fnprefix} /d" "${FINISHED}"
        echo "${_lib_revision}" >> ${FINISHED}
    fi
done
