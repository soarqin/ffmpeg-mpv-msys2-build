git_clone https://github.com/google/angle angle-git
if [ "$result" = true ]; then return; fi
patch_source angle-git 032-angle.patch
pushd ${SRC_ROOT}/angle-git
gyp -Duse_ozone=0 -DOS=win -Dangle_gl_library_type=static_library -Dangle_enable_vulkan=0 -Dangle_use_commit_id=1 --depth . -I gyp/common.gypi src/angle.gyp --no-parallel --format=make --generator-output=generated
make -Cgenerated BUILDTYPE=Release commit_id
make -Cgenerated BUILDTYPE=Release ${MAKE_JOBS}
pushd generated/out/Release/obj.target/src
rm -rf ar && mkdir -p ar
for lib in `find -name '*.a'`
do
  ar x $lib && (ar t $lib | dos2unix | xargs ar rcs $lib.new) && (ar t $lib | dos2unix | xargs rm -f) && mv $lib.new ar/$lib
done
cd ./ar

ar -M <<EOF
CREATE libGLESv2_main.a
ADDLIB libangle_common.a
ADDLIB libangle_image_util.a
ADDLIB libpreprocessor.a
ADDLIB libtranslator.a
ADDLIB libANGLE.a
ADDLIB libGLESv2.a
SAVE
END
EOF

ranlib libEGL.a
ranlib libGLESv2_main.a
mv libGLESv2_main.a ${SRC_ROOT}/angle-git/libGLESv2.a
mv libEGL.a ${SRC_ROOT}/angle-git/libEGL.a
popd

make PREFIX=${BUILD_INSTALL_ROOT} install

popd
