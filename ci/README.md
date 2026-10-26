# Build diagnostics and cache profiles

The Windows and Linux workflows add persistent dependency/source/compiler caches, stage timings, complete logs, generated CMake/Ninja configuration and CTest JUnit. Source optimizations and production LTO remain active. The optional ENABLE_TEST_LTO=OFF profiles compile a separate test library to avoid repeated production LTO test links; the option defaults to ON. Original presets and workflows remain available.

Cache profiles replace compiled PCH with normal forced inclusion of the same header environment, retaining USE_PRECOMPILED_HEADERS. Windows uses embedded compiler debug information and retains linker PDBs. Tests inherit the configured runtime library through setup_target. Generated cache/tool directories are ignored so Git version metadata remains clean. Installed dependency trees and build directories are not restored.

Local example:

```sh
cmake --preset windows-release-cache
cmake --build --preset windows-release-cache
ctest --preset windows-release-cache
```

Local test presets run unit tests. Windows CI compiles integration tests but runs unit tests; Linux CI runs unit and database integration tests against its isolated MariaDB service, using the repository schema. Fixtures use the injected database/logger and verify rollback of the pinned transaction. Account premium expectations follow the production timestamp calculation.

Compiler, runner, configuration, cache and stage diagnostics are retained for 14 days. Binary artifacts are not complete server installations; runtime resources come from the repository. Cache maintenance retains two generated compiler snapshots and one complete dependency snapshot per namespace/ref. Statistics for configuration probes and source compilation are separated. Ninja task durations overlap and do not equal overall wall time.

The initial profile choices come from measurements on the related standalone server. Crystalserver cold and warm builds must be measured independently before claiming the same timings or an optimal default.

## Measured Linux Debug tradeoff

The original PCH profile remains available as `linux-debug`. In the validated summer-update comparison its compile stage took 325 seconds cold and 229 seconds warm, while `linux-debug-cache` took 536 seconds cold and 27 seconds warm with 199/200 cacheable calls reused. CI therefore uses the cache profile for recurring builds; use the original profile when cold-build latency matters more. Both profiles passed unit and isolated database integration tests. These measurements do not guarantee identical times for every runner or source version.
