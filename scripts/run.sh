BUILD_ROOT=$(realpath $SCRIPT_ROOT/../build$ARCH)
BUILD_INSTALL_ROOT=$(realpath $HOME/mingw$ARCH)

pacman -Syq --noconfirm --needed autoconf autogen automake libtool m4 bison flex gzip bzip2 xz tar ca-certificates curl dos2unix doxygen texinfo gettext git mercurial subversion gawk glib2 gperf grep info make nasm yasm pkg-config ${ARCH_PREFIX}toolchain ${ARCH_PREFIX}python2-lxml ${ARCH_PREFIX}python2-six

mkdir -p $BUILD_ROOT

. $SCRIPT_ROOT/env.sh
. $SCRIPT_ROOT/util.sh
. $SCRIPT_ROOT/compile.sh

FINISHED=
if [ -f $BUILD_ROOT/finished ]; then
    FINISHED=$(cat $BUILD_ROOT/finished | xargs)
fi

for v in $SCRIPT_ROOT/[0-9][0-9][0-9]-*.sh; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    strcontains "$FINISHED" "$fnprefix"
    if [ $result == true ]; then
        echo Skipping finished $fn
        continue
    fi
    . $v
    echo $fnprefix >> $BUILD_ROOT/finished
done
