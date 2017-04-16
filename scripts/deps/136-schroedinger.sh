git_clone https://github.com/Distrotech/schroedinger schroedinger-git master
if [ $result == true ]; then return; fi
pushd ${SRC_ROOT}/schroedinger-git
rm -f configure
dos2unix configure.ac
sed -i -e '/-Werror/d' -e '/testsuite/d' -e '/doc\/Makefile/d' -e '/tools\/Makefile/d' configure.ac
sed -i -e 's/ doc tools testsuite//g' Makefile.am
popd
compile_with_configure schroedinger-git --enable-static --disable-shared
