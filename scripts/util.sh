function strcontains {
    if [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]]; then
        result=true
    else
        result=false
    fi
}

function git_clone {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        git clone --recursive $1 $2
    fi
    cd $2
    local branch=master
    if [ $# -gt 2 ]; then
        branch = $3
    fi
    git checkout -- . && git pull --recurse-submodules origin $branch
}

function hg_clone {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        hg clone $1 $2
    fi
    cd $2
    hg revert --all && hg pull -u
}

function svn_checkout {
    cd $SRC_ROOT
    if [ ! -d $SRC_ROOT/$2 ]; then
        svn checkout $1 $2
    fi
    cd $2
    svn revert -R . && svn update
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
