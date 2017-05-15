if [ "x${MPV_VERSION}" == "xgit" ]; then
    git_clone https://github.com/mpv-player/mpv mpv-${MPV_VERSION} master 1
else
    download_file https://github.com/mpv-player/mpv/archive/v${MPV_VERSION}.tar.gz mpv-${MPV_VERSION}
fi
sed -i -e "/^${fnprefix} /d" "${FINISHED}"

pushd ${SRC_ROOT}/mpv-${MPV_VERSION}
./bootstrap.py
python3 waf configure --prefix=${BUILD_INSTALL_ROOT} -o ${BUILD_ROOT}/mpv-${MPV_VERSION} --enable-static-build --disable-manpage-build --enable-dvdread --enable-dvdnav --enable-libarchive
replace_str="LIBPATH_lib\1 = ['${LOCALDESTDIR}/lib','${MINGW_PREFIX}/lib']"
sed -r -i "s:LIBPATH_lib(ass|av(|device|filter)) = .*:${replace_str}:g" ${BUILD_ROOT}/mpv-${MPV_VERSION}/c4che/_cache.py
python3 waf build ${MAKE_JOBS}
popd
pushd ${BUILD_ROOT}/mpv-${MPV_VERSION}
strip ./mpv.exe
popd
