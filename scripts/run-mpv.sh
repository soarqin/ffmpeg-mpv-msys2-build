BUILD_TARGET_SUFFIX=
. ${SCRIPT_ROOT}/setup.sh
. ${SCRIPT_ROOT}/setup-build.sh
. ${SCRIPT_ROOT}/prep.sh

any_dirty=false
#. ${SCRIPT_ROOT}/run-deps.sh
BUILD_TARGET_SUFFIX=_mpv
. ${SCRIPT_ROOT}/setup-build.sh
declare -a components=()
load_components 'mpv'
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
