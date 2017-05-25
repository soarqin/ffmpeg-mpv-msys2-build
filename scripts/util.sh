function git_clone {
    local branch=master
    if [ $# -gt 2 ]; then
        branch=$3
    fi
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        git clone --recursive $1 ${SRC_ROOT}/$2 -b ${branch}
    fi
    pushd ${SRC_ROOT}/$2
    git checkout -- . && git pull --recurse-submodules origin ${branch}
    _lib_revision=$(git reflog -n1 HEAD)
    export _lib_revision="${fnprefix} $2-${_lib_revision/ *}"
    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    popd
    if [ "x${found}" != "x" ]; then
        if [ "x$4" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    else
        result=false
        any_dirty=true
    fi
}

function hg_clone {
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        hg clone $1 ${SRC_ROOT}/$2
    fi
    pushd ${SRC_ROOT}/$2
    hg revert --all && hg pull -u
    export _lib_revision="${fnprefix} $2-$(hg log -r. --template "{node}" | cut -c-8)"
    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    popd
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    else
        result=false
        any_dirty=true
    fi
}

function svn_checkout {
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        svn checkout $1 ${SRC_ROOT}/$2
    fi
    pushd ${SRC_ROOT}/$2
    svn revert -R . && svn update
    export _lib_revision="${fnprefix} $2-r$(svn info --show-item revision)"
    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    popd
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    else
        result=false
        any_dirty=true
    fi
}

function download_file {
    local filename=${1%/download}
    if [ "x$filename" == "x" ]; then
        filename=${1##*/}
    else
        filename=${filename##*/}
    fi
    local dirname=
    if [ $# -gt 1 ]; then
        dirname=$2
    else
        dirname=${filename%.tar*}
    fi
    export _lib_revision="${fnprefix} ${dirname}"
    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return 0
    else
        result=false
        any_dirty=true
    fi
    save_name=${DOWNLOAD_ROOT}/${dirname}.tar${filename#*.tar}
    if [ -f "${SRC_ROOT}/${dirname}" ]; then
        rm -Rf ${SRC_ROOT}/${dirname}
    fi
    if [ ! -f "${save_name}" ]; then
        curl -LJ -o "${save_name}" $1
    fi
    case ${filename} in
        *.tgz) ;&
        *.tar.gz) tar xfz "${save_name}" -C "${SRC_ROOT}"
            ;;
        *.tbz2) ;&
        *.tar.bz2) tar xfj "${save_name}" -C "${SRC_ROOT}"
            ;;
        *.txz) ;&
        *.tar.xz) tar xfJ "${save_name}" -C "${SRC_ROOT}"
            ;;
    esac
}

function patch_source {
    if [ "x$(cat ${SRC_ROOT}/$1/patched >/dev/null 2>&1 || true)" != "x$3" ]; then
        pushd ${SRC_ROOT}/$1
        patch -p1 < ${PATCH_ROOT}/$2
        echo $3 > ./patched
        popd
    fi
}
