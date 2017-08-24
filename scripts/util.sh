function git_clone {
    local branch=master
    if [ $# -gt 2 ]; then
        branch=$3
    fi
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        git clone --recursive $1 ${SRC_ROOT}/$2 -b ${branch}
    fi
    pushd ${SRC_ROOT}/$2
    git clean -dfx . && git checkout -f ${branch} && git submodule foreach 'git clean -dfx && git checkout -f .' && git pull --recurse-submodules origin ${branch}
    _lib_revision=$(git reflog -n1 HEAD)
    export _lib_revision="${fnprefix} $2-${_lib_revision/ *}"
    popd

    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    if [ "x${found}" != "x" ]; then
        if [ "x$4" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    fi
    result=false
    any_dirty=true
}

function hg_clone {
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        hg clone $1 ${SRC_ROOT}/$2
    fi
    pushd ${SRC_ROOT}/$2
    hg clean --all && hg revert --all && hg pull -u
    export _lib_revision="${fnprefix} $2-$(hg log -r. --template "{node}" | cut -c-8)"
    popd

    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    fi
    result=false
    any_dirty=true
}

function svn_checkout {
    if [ ! -d ${SRC_ROOT}/$2 ]; then
        svn checkout $1 ${SRC_ROOT}/$2
    fi
    pushd ${SRC_ROOT}/$2
    svnclean -f && svn revert -R . && svn update
    export _lib_revision="${fnprefix} $2-r$(svn info --show-item revision)"
    popd

    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    fi
    result=false
    any_dirty=true
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
        dirname=${filename%.t*}
    fi
    export _lib_revision="${fnprefix} ${dirname}"
    found=$(grep "^${_lib_revision}\$" "${FINISHED}" || true)
    result=true
    if [ "x${found}" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${_lib_revision} is up-to-date."
            export -n _lib_revision=""
        fi
        return
    fi
    save_name=${DOWNLOAD_ROOT}/${dirname}.t${filename#*.t}
    if [ -d "${SRC_ROOT}/${dirname}" ]; then
        rm -Rf ${SRC_ROOT}/${dirname}
    fi
    if [ ! -f "${save_name}" ]; then
        curl -LJ -o "${save_name}" $1
    fi
    mkdir -p "${SRC_ROOT}/${dirname}"
    case ${filename} in
        *.tgz) ;&
        *.tar.gz) tar xfz "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1 || tar xfz "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1
            ;;
        *.tbz2) ;&
        *.tar.bz2) tar xfj "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1 || tar xfj "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1
            ;;
        *.txz) ;&
        *.tar.xz) tar xfJ "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1 || tar xfJ "${save_name}" -C "${SRC_ROOT}/${dirname}" --strip-components=1
            ;;
    esac
    result=false
    any_dirty=true
}

function patch_source {
    pushd ${SRC_ROOT}/$1
    patch -p1 < ${PATCH_ROOT}/$2
    popd
}

function auto_reconf {
    pushd ${SRC_ROOT}/$1
    autoreconf -fi
    popd
}

function load_components {
    if [ "x${BUILD_COMP}" = "x" ]; then
        for v in ${SCRIPT_ROOT}/$1/[0-9][0-9][0-9]-*.sh; do
            components+=($v)
        done
    else
        for v in ${BUILD_COMP}; do
            for fn in ${SCRIPT_ROOT}/$1/$v-*.sh; do
                if [ -f $fn ]; then
                    components+=($fn)
                fi
            done
        done
    fi
}
