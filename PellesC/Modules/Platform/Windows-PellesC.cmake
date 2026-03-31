# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates
include_guard ()

set(CMAKE_LIBRARY_PATH_FLAG "-libpath:")
set(CMAKE_LINK_LIBRARY_FLAG )

set(CMAKE_C_STANDARD_LIBRARIES_INIT "kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib comctl32.lib delayimp64.lib")

set(CMAKE_CXX_STANDARD_LIBRARIES_INIT "${CMAKE_C_STANDARD_LIBRARIES_INIT}")

# TODO
# CMP0091 & "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL"
# CMP0141 & $<$<CONFIG:Debug,RelWithDebInfo>:Embedded>

set(CMAKE_LINK_DEF_FILE_FLAG "-def:")

# FIXME: I don't understand CMP0197.  How can I manage the architecture
# independently of `LIB` environment variable?

# If user define `-DPELLESC_PROCESSOR_ID=...` - use it, otherwise use `LIB`
# environment variable (see `%PellesCDir%\Bin\povars*.bat`).

message(VERBOSE "Windows-PellesC: ENV{LIB}=$ENV{LIB}")
if (PELLESC_PROCESSOR_ID)
  set(_PELLESC_PROCESSOR_ID ${PELLESC_PROCESSOR_ID})
  message(VERBOSE "Windows-PellesC: PELLESC_PROCESSOR_ID=${PELLESC_PROCESSOR_ID}")
elseif ("$ENV{LIB}" MATCHES 64)
  set(_PELLESC_PROCESSOR_ID x64)
else ()
  set(_PELLESC_PROCESSOR_ID x86)
endif ()
message(VERBOSE "_PELLESC_PROCESSOR_ID=${_PELLESC_PROCESSOR_ID}")
if (_PELLESC_PROCESSOR_ID MATCHES 64)
  set(_PELLESC_ARCHITECTURE_ID AMD64)
  set(_PELLESC_SYSTEM_PROCESSOR AMD64)
else ()
  set(_PELLESC_ARCHITECTURE_ID IA32)
  set(_PELLESC_SYSTEM_PROCESSOR x86)
endif ()
message(VERBOSE "_PELLESC_ARCHITECTURE_ID=${_PELLESC_ARCHITECTURE_ID}")
if (PELLESC_PROCESSOR_ID OR NOT "x$ENV{LIB}" STREQUAL "x")
  set(_PELLESC_LINK_FLAGS "-machine:${_PELLESC_PROCESSOR_ID}")
  set(_PELLESC_C_OBJ_FLAGS "-T${_PELLESC_PROCESSOR_ID}-coff")
  set(_PELLESC_C_ASM_FLAGS "-T${_PELLESC_PROCESSOR_ID}-asm")
  set(_PELLESC_ASM_FLAGS "-A${_PELLESC_ARCHITECTURE_ID}")
  if (NOT CMAKE_SYSTEM_PROCESSOR STREQUAL ${_PELLESC_SYSTEM_PROCESSOR})
    set(CMAKE_SYSTEM_PROCESSOR ${_PELLESC_SYSTEM_PROCESSOR})
    message(VERBOSE "Windows-PellesC: reset CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")
  endif ()
else ()
  set(_PELLESC_LINK_FLAGS "")
  set(_PELLESC_C_OBJ_FLAGS "")
  set(_PELLESC_C_ASM_FLAGS "")
  set(_PELLESC_ASM_FLAGS "")
endif ()
message(VERBOSE "_PELLESC_LINK_FLAGS=${_PELLESC_LINK_FLAGS}")

foreach (t IN ITEMS EXE SHARED MODULE)
  string(APPEND CMAKE_${t}_LINKER_FLAGS_DEBUG_INIT
    " -debug -debugtype:both -dbg")
  string(APPEND CMAKE_${t}_LINKER_FLAGS_RELWITHDEBINFO_INIT
    " -debug -debugtype:both -dbg")
endforeach ()

macro (__windows_compiler_pellesc lang)
  set(CMAKE_SHARED_LIBRARY_CREATE_${lang}_FLAGS "")

  set(CMAKE_${lang}_CREATE_SHARED_LIBRARY
    "<CMAKE_LINKER> <OBJECTS> ${CMAKE_START_TEMP_FILE} -out:<TARGET> -implib:<TARGET_IMPLIB> -dll -version:<TARGET_VERSION_MAJOR>.<TARGET_VERSION_MINOR> ${_PELLESC_LINK_FLAGS} <LINK_FLAGS> <LINK_LIBRARIES> ${CMAKE_END_TEMP_FILE}")
  set(CMAKE_${lang}_CREATE_SHARED_MODULE ${CMAKE_${lang}_CREATE_SHARED_LIBRARY})

  if ("${lang}" MATCHES "ASM")
    set(CMAKE_${lang}_COMPILE_OBJECT
      "<CMAKE_${lang}_COMPILER> ${_PELLESC_ASM_FLAGS} <DEFINES> <INCLUDES> <FLAGS> -Fo<OBJECT> <SOURCE>")
  else ()
    set(CMAKE_${lang}_COMPILE_OBJECT
      "<CMAKE_${lang}_COMPILER> ${_PELLESC_C_OBJ_FLAGS} <DEFINES> <INCLUDES> <FLAGS> -Fo<OBJECT> -c <SOURCE>")
  endif ()

  set(CMAKE_${lang}_CREATE_PREPROCESSED_SOURCE
    "<CMAKE_${lang}_COMPILER> > <PREPROCESSED_SOURCE> <DEFINES> <INCLUDES> <FLAGS> -E <SOURCE>")

  set(CMAKE_${lang}_CREATE_ASSEMBLY_SOURCE
    "<CMAKE_${lang}_COMPILER> ${_PELLESC_C_ASM_FLAGS} <DEFINES> <INCLUDES> <FLAGS> -Fo<ASSEMBLY_SOURCE> <SOURCE>")

  set(CMAKE_${lang}_LINK_DEF_FILE_FLAG "${CMAKE_LINK_DEF_FILE_FLAG}")
  set(CMAKE_${lang}_USE_RESPONSE_FILE_FOR_OBJECTS 1)
  set(CMAKE_${lang}_LINK_EXECUTABLE
    "<CMAKE_LINKER> <OBJECTS> ${CMAKE_START_TEMP_FILE} -out:<TARGET> -implib:<TARGET_IMPLIB> -version:<TARGET_VERSION_MAJOR>.<TARGET_VERSION_MINOR> ${_PELLESC_LINK_FLAGS} <LINK_FLAGS> <LINK_LIBRARIES> ${CMAKE_END_TEMP_FILE}")

  set(CMAKE_${lang}_CREATE_WIN32_EXE "-subsystem:windows")
  set(CMAKE_${lang}_CREATE_CONSOLE_EXE "-subsystem:console")

  if ("${lang}" MATCHES "ASM")
    string(APPEND CMAKE_${lang}_FLAGS_DEBUG_INIT "-Zi")
    string(APPEND CMAKE_${lang}_FLAGS_RELEASE_INIT )
    string(APPEND CMAKE_${lang}_FLAGS_RELWITHDEBINFO_INIT "-Zi")
    string(APPEND CMAKE_${lang}_FLAGS_MINSIZEREL_INIT )
  else ()
    string(APPEND CMAKE_${lang}_FLAGS_DEBUG_INIT "-Zi -Ob0")
    string(APPEND CMAKE_${lang}_FLAGS_RELEASE_INIT "-Ot -Ob2 -DNDEBUG=1")
    string(APPEND CMAKE_${lang}_FLAGS_RELWITHDEBINFO_INIT "-Zi -Ot -Ob1 -DNDEBUG=1")
    string(APPEND CMAKE_${lang}_FLAGS_MINSIZEREL_INIT "-Os -Ob1 -DNDEBUG=1")

    # TODO define generic information about compiler dependencies
    # set(CMAKE_DEPFILE_FLAGS_${lang} "-M -Fo<DEP_TARGET> > <DEP_FILE>")
    # set(CMAKE_${lang}_DEPFILE_FORMAT gcc)
  endif ()

  # linker selection
  message(VERBOSE "Windows-PellesC: input CMAKE_LINKER=${CMAKE_LINKER}")
  cmake_path(GET CMAKE_${lang}_COMPILER PARENT_PATH __PellesC_Path)
  # TODO: resolve user set if ("${CMAKE_LINKER}" STREQUAL "")
    set(CMAKE_LINKER "${__PellesC_Path}/polink")
    message(VERBOSE "Windows-PellesC: resolved CMAKE_LINKER=${CMAKE_LINKER}")
  #endif ()
  # set(CMAKE_${lang}_COMPILER_LINKER_ID PellesC)  # TODO Modules/Platform/Linker/Windows-PellesC...
  # set(CMAKE_${lang}_COMPILER_LINKER_VERSION ${CMAKE_${lang}_LINKER_VERSION})
  set(CMAKE_${lang}_USING_LINKER_SYSTEM "${CMAKE_LINKER}")
  set(CMAKE_${lang}_USING_LINKER_MSVC "${CMAKE_LINKER}")

  # TODO: Right, CMake way? Or set $ENV{ASM} ?
  # Move to CMakeDetermineASMCompiler.cmake ?
  if (TRUE)
    message(VERBOSE "Windows-PellesC: input CMAKE_ASM_COMPILER=${CMAKE_ASM_COMPILER}")
    if (NOT CMAKE_ASM_COMPILER)
      set(CMAKE_ASM_COMPILER "${__PellesC_Path}/poasm.exe")
      message(VERBOSE "Windows-PellesC: resolved CMAKE_ASM_COMPILER=${CMAKE_ASM_COMPILER}")
    endif ()
  else ()
    message(VERBOSE "Windows-PellesC: input ENV{ASM}=$ENV{ASM}")
    if (NOT ENV{ASM})
      set(ENV{ASM} "${__PellesC_Path}/poasm")
      message(VERBOSE "Windows-PellesC: resolved ENV{ASM}=$ENV{ASM}")
    endif ()
  endif ()

  # RC
  if (NOT CMAKE_RC_COMPILER_INIT)
    set(CMAKE_RC_COMPILER_INIT porc)
  endif ()
  if (NOT CMAKE_RC_COMPILE_OBJECT)
    set(CMAKE_RC_COMPILE_OBJECT
      "<CMAKE_RC_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -Fo<OBJECT> <SOURCE>")
  endif ()
  enable_language(RC)
endmacro ()
