if [ "x${MPV_VERSION}" == "xgit" ]; then
    git_clone https://github.com/mpv-player/mpv mpv-${MPV_VERSION} master 1
else
    download_file https://github.com/mpv-player/mpv/archive/v${MPV_VERSION}.tar.gz mpv-${MPV_VERSION}
fi
sed -i -e "/^${fnprefix} /d" "${FINISHED}"

export PKG_CONFIG_PATH=$(realpath -m ${SCRIPT_ROOT}/../dist/${ARCH}_mpv${BUILD_EXTRA_SUFFIX}/lib/pkgconfig):${PKG_CONFIG_PATH}
pushd ${SRC_ROOT}/mpv-${MPV_VERSION}
./bootstrap.py
LDFLAGS='-Wl,-Bstatic -lpthread' /usr/bin/python2 waf configure --prefix=$(realpath -m ${SCRIPT_ROOT}/../dist/${ARCH}_mpv${BUILD_EXTRA_SUFFIX}) -o ${BUILD_ROOT}/mpv-${MPV_VERSION} --enable-static-build --disable-manpage-build --enable-dvdread --enable-dvdnav --enable-libarchive
replace_str="LIBPATH_lib\1 = ['${LOCALDESTDIR}/lib','${MINGW_PREFIX}/lib']"
sed -r -i "s:LIBPATH_lib(ass|av(|device|filter)) = .*:${replace_str}:g" ${BUILD_ROOT}/mpv-${MPV_VERSION}/c4che/_cache.py
/usr/bin/python2 waf build ${MAKE_JOBS}
/usr/bin/python2 waf install
popd
