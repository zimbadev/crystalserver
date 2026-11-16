# vcpkg overlay ports

Ports in this directory are applied on top of the registry pinned by
`builtin-baseline` in `vcpkg.json` (`vcpkg-configuration.json` points
`overlay-ports` here).

## boost-locale

`boost-1.90.0` calls `source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}/include/boost/locale" ...)`
with a file list that still contains `include/boost/locale.hpp`. That header
is not inside the `include/boost/locale` directory, so CMake (3.x) aborts the
dependency build with:

```text
source_group ROOT: ".../include/boost/locale" is not a prefix of ".../include/boost/locale.hpp"
```

This breaks every vcpkg install of `boost-locale` during the configure step,
which is what fails the Windows/Linux/macOS builds.

`fix-source-group.patch` backports the upstream fix
(https://github.com/boostorg/boost/issues/1162) and only changes which files
CMake groups in the IDE; it does not affect the produced library.

Delete this overlay once `builtin-baseline` is updated to a vcpkg commit
whose `boost-locale` port already contains the fix (Boost 1.91+).
