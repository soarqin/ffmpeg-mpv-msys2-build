git_clone https://anongit.freedesktop.org/git/fribidi/fribidi.git fribidi
if [ $result == true ]; then return; fi
cd $BUILD_ROOT
mkdir -p fribidi
cd fribidi
mkdir -p gen.tab
cp -rf $SRC_ROOT/fribidi/gen.tab/unidata gen.tab/
JOBS_OLD=$JOBS
JOBS=-j1
compile_with_configure fribidi --enable-static --disable-shared --without-glib
JOBS=$JOBS_OLD
