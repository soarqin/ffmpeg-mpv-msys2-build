git_clone https://github.com/Distrotech/schroedinger schroedinger-git master
if [ $result == true ]; then return; fi
patch_source schroedinger-git 136-schroedinger.patch
pushd ${SRC_ROOT}/schroedinger-git
rm -f configure
dos2unix configure.ac
popd
compile_with_configure schroedinger-git --enable-static --disable-shared
