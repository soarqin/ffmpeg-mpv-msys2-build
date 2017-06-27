py_ver=${PYTHON_VERSION}${PYTHON_RC}
download_file https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${py_ver}.tar.xz

if [ $result == true ]; then return; fi

patch_source Python-${py_ver} 053-Python.patch

pushd ${SRC_ROOT}/Python-${py_ver}

autoreconf -fi

touch Include/graminit.h
touch Python/graminit.c
touch Parser/Python.asdl
touch Parser/asdl.py
touch Parser/asdl_c.py
touch Include/Python-ast.h
touch Python/Python-ast.c
echo \"\" > Parser/pgen.stamp

# Ensure that we are using the system copy of various libraries (expat, zlib and libffi),
# rather than copies shipped in the tarball
rm -rf Modules/expat Modules/zlib Modules/_ctypes/{darwin,libffi}*

popd

mkdir -p ${BUILD_ROOT}/Python-${py_ver}
pushd ${BUILD_ROOT}/Python-${py_ver}

# Workaround for conftest error on 64-bit builds
export ac_cv_working_tzset=no

`realpath -m --relative-to=. $SRC_ROOT`/Python-${py_ver}/configure \
  --prefix=${BUILD_INSTALL_ROOT} \
  --host=${MINGW_CHOST} \
  --build=${MINGW_CHOST} \
  --enable-shared \
  --enable-optimizations \
  --with-system-expat \
  --with-system-ffi \
  --with-threads \
  --without-ensurepip \
  OPT="" \
  CFLAGS="-fwrapv -D__USE_MINGW_ANSI_STDIO=1 -DNDEBUG" \
  CXXFLAGS="-fwrapv -D__USE_MINGW_ANSI_STDIO=1 -DNDEBUG" \
  LDFLAGS="-s" LIBS="-Wl,-Bstatic -lpthread -lgcov -Wl,-Bdynamic"

make ${MAKE_JOBS}
make install
popd

pushd ${BUILD_INSTALL_ROOT}/lib
cp -f python3.6/config-3.6m/libpython3.6m.dll.a .
popd
