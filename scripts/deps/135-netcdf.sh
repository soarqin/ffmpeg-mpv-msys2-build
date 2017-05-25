if [ "x${NETCDF_VERSION}" == "xgit" ]; then
    git_clone https://github.com/Unidata/netcdf-c netcdf-c-${NETCDF_VERSION}
    if [ $result == true ]; then return; fi
    patch_source netcdf-c-${NETCDF_VERSION} 135-netcdf.patch 1
else
    download_file https://github.com/Unidata/netcdf-c/archive/v${NETCDF_VERSION}.tar.gz netcdf-c-${NETCDF_VERSION}
fi
if [ $result == true ]; then return; fi
compile_with_configure netcdf-c-${NETCDF_VERSION} --enable-static --disable-shared --disable-testsets --disable-utilities --disable-dap --disable-netcdf-4
