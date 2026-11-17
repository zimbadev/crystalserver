# Build tuning shared by CI and local builds: linker choice, parallelism limits and a
# low-memory mode for machines where RAM, not CPU, is what runs out first.
#
# Options (all off / empty by default, so an untouched build behaves as before):
#   OPTIONS_LINKER            mold | lld | (empty = toolchain default). GCC/Clang only.
#   OPTIONS_LOW_MEMORY_BUILD  ON = trade CPU time for a lower peak RAM use:
#                               - GCC collects garbage more often (--param ggc-*),
#                               - compile jobs are capped from the installed RAM
#                                 (~1.5 GB reserved for the system, one job per ~1.5 GB left),
#                               - links run one at a time.
#   OPTIONS_COMPILE_JOBS      max parallel compile jobs (Ninja only), overrides the RAM-based cap
#   OPTIONS_LINK_JOBS         max parallel link jobs (Ninja only)
#
# Include this before any target is created.

set(OPTIONS_LINKER "" CACHE STRING "Linker for GCC/Clang builds: mold, lld or empty for the default")
option(OPTIONS_LOW_MEMORY_BUILD "Use more CPU time to keep the peak RAM use of the build low" OFF)
set(OPTIONS_COMPILE_JOBS "" CACHE STRING "Max parallel compile jobs with Ninja (empty = no limit)")
set(OPTIONS_LINK_JOBS "" CACHE STRING "Max parallel link jobs with Ninja (empty = no limit)")

# === Linker ===
if(OPTIONS_LINKER AND NOT MSVC)
	find_program(BUILD_TUNING_LINKER NAMES "${OPTIONS_LINKER}" "ld.${OPTIONS_LINKER}")
	if(BUILD_TUNING_LINKER)
		add_link_options("-fuse-ld=${OPTIONS_LINKER}")
		message(STATUS "Linker: ${OPTIONS_LINKER} (${BUILD_TUNING_LINKER})")
	else()
		message(STATUS "Linker: ${OPTIONS_LINKER} not found, using the toolchain default")
	endif()
endif()

# === Low memory mode ===
set(_build_tuning_compile_jobs "${OPTIONS_COMPILE_JOBS}")
set(_build_tuning_link_jobs "${OPTIONS_LINK_JOBS}")

if(OPTIONS_LOW_MEMORY_BUILD)
	if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		# GCC only frees memory when its heap has grown by ggc-min-expand percent over
		# ggc-min-heapsize. The defaults scale with the machine RAM and favour speed;
		# these values make it collect early and often: slower compiles, much lower peak.
		add_compile_options("SHELL:--param ggc-min-expand=10" "SHELL:--param ggc-min-heapsize=32768")
	endif()

	if(NOT _build_tuning_compile_jobs)
		# The heaviest translation units of these projects peak at about 1.6 GB in the compiler.
		# Keep ~1.5 GB for the rest of the system and allow one job per remaining ~1.5 GB.
		cmake_host_system_information(RESULT _build_tuning_ram_mib QUERY TOTAL_PHYSICAL_MEMORY)
		cmake_host_system_information(RESULT _build_tuning_cpus QUERY NUMBER_OF_LOGICAL_CORES)
		math(EXPR _build_tuning_compile_jobs "(${_build_tuning_ram_mib} - 1536) / 1536")
		if(_build_tuning_compile_jobs LESS 1)
			set(_build_tuning_compile_jobs 1)
		endif()
		if(_build_tuning_compile_jobs GREATER _build_tuning_cpus)
			set(_build_tuning_compile_jobs ${_build_tuning_cpus})
		endif()
	endif()

	if(NOT _build_tuning_link_jobs)
		set(_build_tuning_link_jobs 1)
	endif()
endif()

# === Ninja job pools ===
if(CMAKE_GENERATOR MATCHES "Ninja")
	if(_build_tuning_compile_jobs)
		set_property(GLOBAL APPEND PROPERTY JOB_POOLS "tuning_compile=${_build_tuning_compile_jobs}")
		set(CMAKE_JOB_POOL_COMPILE tuning_compile)
		message(STATUS "Compile jobs limited to ${_build_tuning_compile_jobs}")
	endif()
	if(_build_tuning_link_jobs)
		set_property(GLOBAL APPEND PROPERTY JOB_POOLS "tuning_link=${_build_tuning_link_jobs}")
		set(CMAKE_JOB_POOL_LINK tuning_link)
		message(STATUS "Link jobs limited to ${_build_tuning_link_jobs}")
	endif()
elseif(_build_tuning_compile_jobs OR _build_tuning_link_jobs)
	message(STATUS "Job limits need the Ninja generator; pass -j to the build tool instead")
endif()
