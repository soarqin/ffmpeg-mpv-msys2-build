if [ "x${LUAJIT_VERSION}" == "xgit" ]; then
    git_clone http://luajit.org/git/luajit-2.0.git LuaJIT-${LUAJIT_VERSION} v2.1
else
    download_file http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
fi
if [ $result == true ]; then return; fi
rm -rf ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
mkdir -p ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
pushd ${BUILD_ROOT}/LuaJIT-${LUAJIT_VERSION}
cp -Rf ${SRC_ROOT}/LuaJIT-${LUAJIT_VERSION}/* .
sed -i -e "s,PREFIX= /usr/local,PREFIX= ${BUILD_INSTALL_ROOT},g" Makefile
sed -i -e 's,^#BUILDMODE= static,BUILDMODE= static,g' src/Makefile
sed -i -e 's, -ldl$,,g' etc/luajit.pc
make ${JOBS} install
popd
