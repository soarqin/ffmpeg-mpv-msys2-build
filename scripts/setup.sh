if [ "x${USE_REPO}" == "x" ]; then
    . ${SCRIPT_ROOT}/version.inc
else
    . ${SCRIPT_ROOT}/version-repo.inc
fi

case `gcc -dumpmachine` in
    x86_64-w64-mingw32)
        ARCH=64
        ;;
    i686-w64-mingw32)
        ARCH=32
        ;;
    *)
        if [ "x${ARCH}" != "x32" ]; then
            ARCH=64
        fi
        ;;
esac
echo $ARCH
if [ "x${ARCH}" = "x64" ]; then
    BUILD_CHOST=x86_64-w64-mingw32
    ARCH_PREFIX=mingw-w64-x86_64-
else
    BUILD_CHOST=i686-w64-mingw32
    ARCH_PREFIX=mingw-w64-i686-
fi
