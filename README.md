Note
====
* These Scripts is written to build static FFMPEG and MPV with most of depedencies on MSYS2.

> ## IMPORTANT!!
> * FFMPEG links to non-free delay-loaded libfdk-aac-1.dll which are not distributable freely.
> * If you want to distribute compiled binaries, be sure to supply libfdk-aac-1.dll in non-free part.

Usage
=====
<table>
<tr><td>./ffmpeg.sh</td><td>Build FFMPEG on MSYS2 with MinGW i686/x86_64</td></tr>
<tr><td>./mpv.sh</td><td>Build MPV on MSYS2 with MinGW64 i686/x86_64</td></tr>
</table>

Env vars
========
<table>
<tr><td>NODEPS</td><td>Set to disable MSYS2 packages' installation/update on startup</td></tr>
<tr><td>VERSION_FILE</td><td>Set to 'scripts/version-repo.inc' to make use of latest codes in svn/hg/git for most components</td></tr>
</table>
