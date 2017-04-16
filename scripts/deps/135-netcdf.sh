if [ "x${NETCDF_VERSION}" == "xgit" ]; then
    git_clone https://github.com/Unidata/netcdf-c netcdf-c-${NETCDF_VERSION}
else
    download_file https://github.com/Unidata/netcdf-c/archive/v${NETCDF_VERSION}.tar.gz netcdf-c-${NETCDF_VERSION}
fi
if [ $result == true ]; then return; fi
pushd ${SRC_ROOT}/netcdf-c-${NETCDF_VERSION}
if [ -f libdispatch/utf8proc.h ]; then
    sed -i -e 's,#ifdef _WIN32,#if 0,g' libdispatch/utf8proc.h
fi
popd
compile_with_configure netcdf-c-${NETCDF_VERSION} --enable-static --disable-shared --disable-testsets --disable-utilities --disable-dap --disable-netcdf-4
