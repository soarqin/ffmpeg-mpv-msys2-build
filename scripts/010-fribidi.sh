git_clone git://anongit.freedesktop.org/fribidi/fribidi fribidi
cd $BUILD_ROOT
mkdir -p fribidi
cd fribidi
mkdir -p gen.tab
cp -rf $SRC_ROOT/fribidi/gen.tab/unidata gen.tab/
JOBS_OLD=$JOBS
JOBS=-j1
compile_with_configure fribidi --enable-static --disable-shared
JOBS=$JOBS_OLD
