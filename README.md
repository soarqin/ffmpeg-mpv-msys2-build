# Note
* These Scripts is written to build static FFMPEG and MPV with most of depedencies on MSYS2.
> ## IMPORTANT!!
> * FFMPEG links to non-free libfdk_aac by default so that the binaries are not distributable.
> * If you need a distributable ffmpeg, set NO_FDK_AAC=1 to avoid linking to libfdk_aac.

# Usage
* scripts/ffmpeg32.sh   Build FFMPEG on MSYS2 with MinGW32
* scripts/ffmpeg64.sh   Build FFMPEG on MSYS2 with MinGW64
* scripts/mpv32.sh      Build MPV on MSYS2 with MinGW32
* scripts/mpv64.sh      Build MPV on MSYS2 with MinGW64
