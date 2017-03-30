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
