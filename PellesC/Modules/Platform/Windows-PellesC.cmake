# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.
include_guard()

set(CMAKE_LIBRARY_PATH_FLAG "-libpath:")
set(CMAKE_LINK_DEF_FILE_FLAG "-def:")
set(CMAKE_LINK_LIBRARY_FLAG "")

set(CMAKE_C_STANDARD_LIBRARIES_INIT "kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib comctl32.lib delayimp64.lib")
set(CMAKE_CXX_STANDARD_LIBRARIES_INIT "${CMAKE_C_STANDARD_LIBRARIES_INIT}")

# FIXME: I don't understand CMP0197.  How can I manage the architecture
# independently of `LIB` environment variable?

# If user define `-DPELLESC_PROCESSOR_ID=...` - use it, otherwise use `LIB`
# environment variable (see `%PellesCDir%\Bin\povars*.bat`).

if (PELLESC_PROCESSOR_ID)
  set(_PELLESC_PROCESSOR_ID ${PELLESC_PROCESSOR_ID})
elseif ("$ENV{LIB}" MATCHES 64)
  set(_PELLESC_PROCESSOR_ID x64)
else ()
  set(_PELLESC_PROCESSOR_ID x86)
endif ()
if (_PELLESC_PROCESSOR_ID MATCHES 64)
  set(_PELLESC_ARCHITECTURE_ID AMD64)
  set(_PELLESC_SYSTEM_PROCESSOR AMD64)
else ()
  set(_PELLESC_ARCHITECTURE_ID IA32)
  set(_PELLESC_SYSTEM_PROCESSOR x86)
endif ()
if (PELLESC_PROCESSOR_ID OR NOT "x$ENV{LIB}" STREQUAL "x")
  set(_PELLESC_LINK_FLAGS "-machine:${_PELLESC_PROCESSOR_ID}")
  set(_PELLESC_C_OBJ_FLAGS "-T${_PELLESC_PROCESSOR_ID}-coff")
  set(_PELLESC_C_ASM_FLAGS "-T${_PELLESC_PROCESSOR_ID}-asm")
  set(_PELLESC_ASM_FLAGS "-A${_PELLESC_ARCHITECTURE_ID}")
  if (NOT CMAKE_SYSTEM_PROCESSOR STREQUAL ${_PELLESC_SYSTEM_PROCESSOR})
    set(CMAKE_SYSTEM_PROCESSOR ${_PELLESC_SYSTEM_PROCESSOR})
  endif ()
else ()
  set(_PELLESC_LINK_FLAGS "")
  set(_PELLESC_C_OBJ_FLAGS "")
  set(_PELLESC_C_ASM_FLAGS "")
  set(_PELLESC_ASM_FLAGS "")
endif ()

foreach (t IN ITEMS EXE SHARED MODULE)
  string(APPEND CMAKE_${t}_LINKER_FLAGS_DEBUG_INIT
    " -debug -debugtype:both -dbg")
  string(APPEND CMAKE_${t}_LINKER_FLAGS_RELWITHDEBINFO_INIT
    " -debug -debugtype:both -dbg")
endforeach ()

macro(__windows_compiler_pellesc lang)
  set(CMAKE_${lang}_CREATE_STATIC_LIBRARY "<CMAKE_AR> <LINK_FLAGS> -out:<TARGET> <OBJECTS>")

  set(CMAKE_${lang}_CREATE_SHARED_LIBRARY
    "<CMAKE_LINKER> <OBJECTS> ${CMAKE_START_TEMP_FILE} -out:<TARGET> -implib:<TARGET_IMPLIB> -dll -version:<TARGET_VERSION_MAJOR>.<TARGET_VERSION_MINOR> ${_PELLESC_LINK_FLAGS} <LINK_FLAGS> <LINK_LIBRARIES> ${CMAKE_END_TEMP_FILE}")
  set(CMAKE_${lang}_CREATE_SHARED_MODULE "${CMAKE_${lang}_CREATE_SHARED_LIBRARY}")
  set(CMAKE_SHARED_LIBRARY_CREATE_${lang}_FLAGS "")

  set(CMAKE_${lang}_USE_RESPONSE_FILE_FOR_OBJECTS 1)
  set(CMAKE_${lang}_LINK_EXECUTABLE
    "<CMAKE_LINKER> <OBJECTS> ${CMAKE_START_TEMP_FILE} -out:<TARGET> -implib:<TARGET_IMPLIB> -version:<TARGET_VERSION_MAJOR>.<TARGET_VERSION_MINOR> ${_PELLESC_LINK_FLAGS} <LINK_FLAGS> <LINK_LIBRARIES> ${CMAKE_END_TEMP_FILE}")

  set(CMAKE_${lang}_LINK_DEF_FILE_FLAG "${CMAKE_LINK_DEF_FILE_FLAG}")

  set(CMAKE_${lang}_CREATE_WIN32_EXE "-subsystem:windows")
  set(CMAKE_${lang}_CREATE_CONSOLE_EXE "-subsystem:console")

  cmake_path(GET CMAKE_${lang}_COMPILER PARENT_PATH __PellesC_Path)
  set(CMAKE_LINKER "${__PellesC_Path}/polink")
  set(CMAKE_${lang}_USING_LINKER_SYSTEM "${CMAKE_LINKER}")
  set(CMAKE_${lang}_USING_LINKER_MSVC "${CMAKE_LINKER}")

  if(NOT CMAKE_RC_COMPILER_INIT)
    set(CMAKE_RC_COMPILER_INIT porc)
  endif()
  enable_language(RC)
endmacro()
