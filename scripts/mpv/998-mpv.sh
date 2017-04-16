if [ "x${MPV_VERSION}" == "xgit" ]; then
    git_clone https://github.com/mpv-player/mpv mpv-${MPV_VERSION} master 1
else
    download_file https://github.com/mpv-player/mpv/archive/v${MPV_VERSION}.tar.gz mpv-${MPV_VERSION}
fi
if [ $any_dirty != true ]; then return; fi
sed -i -e "/^${fnprefix} /d" "${FINISHED}"

pushd ${SRC_ROOT}/mpv-${MPV_VERSION}
./bootstrap.py
python3 waf configure --prefix=${BUILD_INSTALL_ROOT} -o ${BUILD_ROOT}/mpv-${MPV_VERSION} --enable-static-build --disable-manpage-build
python3 waf build ${JOBS}
popd
