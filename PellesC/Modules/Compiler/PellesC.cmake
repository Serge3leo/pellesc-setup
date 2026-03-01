# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)
include_guard()

# TODO set(_id_pellesc_ "PellesC")
# TODO message("PellesC: CMAKE_ROOT=${CMAKE_ROOT}")

macro(__compiler_pellesc lang)
  if ("x${lang}" STREQUAL "xC")
    # TODO set(CMAKE_${lang}_CREATE_PREPROCESSED_SOURCE "<CMAKE_${lang}_COMPILER> ${_ORANGEC_COMPILE_${lang}} -! <SOURCE> <DEFINES> <INCLUDES> <FLAGS> +i -o <PREPROCESSED_SOURCE>")
    # TODO set(CMAKE_${lang}_CREATE_ASSEMBLY_SOURCE     "<CMAKE_${lang}_COMPILER> ${_ORANGEC_COMPILE_${lang}} -! <SOURCE> <DEFINES> <INCLUDES> <FLAGS> -S -o <ASSEMBLY_SOURCE>")
  endif ()
  set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> -c <DEFINES> <INCLUDES> <FLAGS> <SOURCE> -Fo<OBJECT>")

  # TODO ASM check
  set(CMAKE_DEPFILE_FLAGS_${lang} "-M -Fo<DEP_TARGET> > <DEP_FILE>")
  set(CMAKE_${lang}_DEPFILE_FORMAT gcc)
  # set(CMAKE_${lang}_DEPENDS_USE_COMPILER TRUE)

  set(CMAKE_C_LINK_MODE DRIVER)

  string(APPEND CMAKE_${lang}_FLAGS_INIT " ")
  string(APPEND CMAKE_${lang}_FLAGS_DEBUG_INIT " -Zi")
  string(APPEND CMAKE_${lang}_FLAGS_RELEASE_INIT " -O2 -DNDEBUG")
  string(APPEND CMAKE_${lang}_FLAGS_MINSIZEREL_INIT " -O1 -DNDEBUG")
  string(APPEND CMAKE_${lang}_FLAGS_RELWITHDEBINFO_INIT " -O2 -Zi -DNDEBUG")

  # TODO set(CMAKE_${lang}_CREATE_SHARED_LIBRARY "<CMAKE_${lang}_COMPILER> -! <FLAGS> -o <TARGET> --out-implib <TARGET_IMPLIB> <CMAKE_SHARED_LIBRARY_${lang}_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES>")
  # TODO set(CMAKE_${lang}_CREATE_SHARED_MODULE "${CMAKE_${lang}_CREATE_SHARED_LIBRARY}")
  # TODO set(CMAKE_${lang}_CREATE_STATIC_LIBRARY "<CMAKE_${lang}_COMPILER> -! -static -o <TARGET> <LINK_FLAGS> <OBJECTS> ")
  set(CMAKE_LINKER "polink")
  set(CMAKE_${lang}_LINK_EXECUTABLE "<CMAKE_LINKER> /out:<TARGET> <FLAGS> <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES>")

  set(CMAKE_LIBRARY_PATH_FLAG " /LIBPATH")
  # TODO set(CMAKE_SHARED_LIBRARY_CREATE_${lang}_FLAGS "-! -shared")

  set(CMAKE_${lang}_RESPONSE_FILE_FLAG "@")
  set(CMAKE_${lang}_RESPONSE_FILE_LINK_FLAG "@")
endmacro()
