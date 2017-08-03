BUILD_TARGET_SUFFIX=
. ${SCRIPT_ROOT}/setup.sh
. ${SCRIPT_ROOT}/obs-setup-build.sh
. ${SCRIPT_ROOT}/prep.sh

any_dirty=false

for v in ${SCRIPT_ROOT}/obs/{001,009,081,131}-*.sh; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    export -n _lib_revision=""
    . $v
    if [ "x${_lib_revision}" != "x" ]; then
        sed -i -e "/^${fnprefix} /d" "${FINISHED}"
        echo "${_lib_revision}" >> ${FINISHED}
    fi
done

pushd ${BUILD_INSTALL_ROOT}
pushd lib
if [ -f libz.dll.a ]; then
    mv -f libz.dll.a libz.a
fi
if [ -f libx264.dll.a ]; then
    mv -f libx264.dll.a libx264.a
fi
popd

pushd bin
cp -f ${SRC_ROOT}/zlib-${ZLIB_VERSION}/win32/zlib.def .
dlltool -m i386:x86-64 -d zlib.def -l zlib.lib -D zlib1.dll

dlltool -z x264.orig.def --export-all-symbols libx264-*.dll
grep "EXPORTS\|x264" x264.orig.def > x264.def
rm -f x264.orig.def
sed -i -e "/\\t.*DATA/d" -e "/\\t\".*/d" -e "s/\s@.*//" x264.def
dlltool -m i386:x86-64 -d x264.def -l x264.lib -D libx264-*.dll

dlltool -z curl.orig.def --export-all-symbols libcurl-*.dll
grep "EXPORTS\|curl_" curl.orig.def > curl.def
rm -f curl.orig.def
sed -i -e "/\\t.*DATA/d" -e "/\\t\".*/d" -e "s/\s@.*//" curl.def
dlltool -m i386:x86-64 -d curl.def -l curl.lib -D libcurl-*.dll

dlltool -z speexdsp.orig.def --export-all-symbols libspeexdsp-1.dll
grep "EXPORTS\|filterbank_\|jitter_\|speex_\|spx_" speexdsp.orig.def > speexdsp.def
rm -f speexdsp.orig.def
sed -i -e "/\\t.*DATA/d" -e "/\\t\".*/d" -e "s/\s@.*//" speexdsp.def
dlltool -m i386:x86-64 -d speexdsp.def -l speexdsp.lib -D libspeexdsp-1.dll

dlltool -z fdk-aac.orig.def --export-all-symbols libfdk-aac-1.dll
grep $'EXPORTS\|\taac' fdk-aac.orig.def > fdk-aac.def
rm -rf fdk-aac.orig.def
sed -i -e "/\\t.*DATA/d" -e "/\\t\".*/d" -e "s/\s@.*//" fdk-aac.def
dlltool -m i386:x86-64 -d fdk-aac.def -l fdk-aac.lib -D libfdk-aac-1.dll
popd
popd

. ${SCRIPT_ROOT}/obs-run-deps.sh

for v in ${SCRIPT_ROOT}/obs/99[0-9]-*.sh; do
    fn=${v##*/}
    fnprefix=${fn:0:3}
    export -n _lib_revision=""
    . $v
    if [ "x${_lib_revision}" != "x" ]; then
        sed -i -e "/^${fnprefix} /d" "${FINISHED}"
        echo "${_lib_revision}" >> ${FINISHED}
    fi
done

pushd ${BUILD_INSTALL_ROOT}
mkdir -p lib${ARCH}
cp bin/*.lib lib${ARCH}/
popd
