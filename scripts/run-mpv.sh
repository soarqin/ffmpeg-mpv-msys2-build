BUILD_EXTRA_SUFFIX=_mpv

. ${SCRIPT_ROOT}/prep.sh

for v in ${SCRIPT_ROOT}/mpv/[0-9][0-9][0-9]-*.sh; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    export -n _lib_revision=""
    . $v
    if [ "x${_lib_revision}" != "x" ]; then
        sed -i -e "/^${fnprefix} /d" "${FINISHED}"
        echo "${_lib_revision}" >> ${FINISHED}
    fi
done
