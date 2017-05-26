if [ "x${LUAJIT_VERSION}" == "xgit" ]; then
    git_clone http://luajit.org/git/luajit-2.0.git LuaJIT-${LUAJIT_VERSION} v2.1
else
    download_file http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
patch_source LuaJIT-${LUAJIT_VERSION} 051-luajit.patch 1
rm -rf ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
mkdir -p ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
pushd ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
cp -Rf ${SRC_ROOT}/LuaJIT-${LUAJIT_VERSION}/* .
make ${JOBS} install
popd
