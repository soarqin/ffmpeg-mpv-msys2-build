function git_clone {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        git clone --recursive $1 $2
    fi
    cd $2
    local branch=master
    if [ $# -gt 2 ]; then
        branch=$3
    fi
    git checkout -- . && git pull --recurse-submodules origin $branch
    revision=$(git reflog -n1 HEAD)
    export revision="${fnprefix} $2-${revision/ *}"
    found=$(grep "^$revision\$" "$FINISHED" || true)
    result=true
    if [ "x$found" != "x" ]; then
        if [ "x$4" == "x" ]; then
            echo "${revision} is up-to-date."
            export -n revision=""
        fi
        return
    else
        result=false
        any_dirty=true
    fi
}

function hg_clone {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        hg clone $1 $2
    fi
    cd $2
    hg revert --all && hg pull -u
    export revision="${fnprefix} $2-$(hg log -r. --template "{node}" | cut -c-8)"
    found=$(grep "^$revision\$" "$FINISHED" || true)
    result=true
    if [ "x$found" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${revision} is up-to-date."
            export -n revision=""
        fi
        return
    else
        result=false
        any_dirty=true
    fi
}

function svn_checkout {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        svn checkout $1 $2
    fi
    cd $2
    svn revert -R . && svn update
    export revision="${fnprefix} $2-r$(svn info --show-item revision)"
    found=$(grep "^$revision\$" "$FINISHED" || true)
    result=true
    if [ "x$found" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${revision} is up-to-date."
            export -n revision=""
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
        dirname=${filename%.tar.*}
    fi
    export revision="${fnprefix} ${dirname}"
    found=$(grep "^$revision\$" "$FINISHED" || true)
    result=true
    if [ "x$found" != "x" ]; then
        if [ "x$3" == "x" ]; then
            echo "${revision} is up-to-date."
            export -n revision=""
        fi
        return 0
    else
        result=false
        any_dirty=true
    fi
    if [ ! -d $SRC_ROOT/$dirname ]; then
        local ext=${filename#*.tar.}
        cd $SRC_ROOT
        case $ext in
            gz) curl -LJ $1 | tar xz
                ;;
            bz2) curl -LJ $1 | tar xj
                ;;
            xz) curl -LJ $1 | tar xJ
                ;;
        esac
    fi
}
