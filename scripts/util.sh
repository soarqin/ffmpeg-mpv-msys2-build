function strcontains {
    if [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]]; then
        result=true
    else
        result=false
    fi
}

function git_clone {
    cd $SRC_ROOT || exit 1
    if [ ! -d $SRC_ROOT/$2 ]; then
        git clone --recursive $1 $2 || exit 1
    fi
    cd $2 || exit 1
    git fetch
    local branch=master
    if [ $# -gt 2 ]; then
        branch = $3
    fi
    git checkout -- . && git pull --recurse-submodules origin $branch || exit 1
}

function download_file {
    local filename=${1##*/}
    local dirname=${filename%.tar.*}
    if [ ! -d $SRC_ROOT/$dirname ]; then
        local ext=${filename#*.tar.}
        cd $SRC_ROOT || exit 1
        case $ext in
            gz) curl -LJ $1 | tar xz || exit 1
                ;;
            bz2) curl -LJ $1 | tar xj || exit 1
                ;;
            xz) curl -LJ $1 | tar xJ || exit 1
                ;;
        esac
    fi
}
