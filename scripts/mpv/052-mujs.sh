git_clone git://git.ghostscript.com/mujs.git mujs-git
if [ $result == true ]; then return; fi
mkdir -p ${SRC_ROOT}/mujs-git
pushd ${SRC_ROOT}/mujs-git
make prefix=${BUILD_INSTALL_ROOT} install-static ${MAKE_JOBS}
popd
