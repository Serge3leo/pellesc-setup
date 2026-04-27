# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

include(_support_)

file(GLOB ID_PELLESC
     "${CMAKE_CURRENT_LIST_DIR}/Modules/Compiler/*-DetermineCompiler.cmake")
if (NOT ${ID_PELLESC} MATCHES "/([^/-]+)-DetermineCompiler\\.cmake$")
    message(FATAL_ERROR "FAIL: _patches_: Invalid Id of Pelles C compiller")
endif ()
set(ID_PELLESC ${CMAKE_MATCH_1})

# ID_PELLESC must be before
set(ID_LATER "MSVC")

set(IdDetection_module "CMakeCompilerIdDetection.cmake")
set(IdDetection_match "(\n[ \t]+TinyCC[ \t]*\n)([ \t]+Bruce[ \t]*\n)")
set(IdDetection_replace "\\1        # pellesc-setup patch\n        ${ID_PELLESC}\n\\2")
set(IdDetection_rev_match "(\n[ \t]+TinyCC[ \t]*\n).*#.*patch.*\n([ \t]+Bruce[ \t]*\n)")
set(IdDetection_rev_replace "\\1\\2")
set(IdDetection_detect "${ID_PELLESC}")

set(DetermineASM_module "CMakeDetermineASMCompiler.cmake")
set(ASM_PREV "# Table of per-vendor compiler id flags with expected output.")
set(ASM_NEXT "list.APPEND CMAKE_ASM.{ASM_DIALECT}_COMPILER_ID_VENDORS GNU .")
set(DetermineASM_match "(\n[ \t]+${ASM_PREV}[ \t]*\n)([ \t]+${ASM_NEXT}[ \t]*\n)")
set(DetermineASM_replace "\\1
  # pellesc-setup patch
  list(APPEND CMAKE_ASM\${ASM_DIALECT}_COMPILER_ID_VENDORS ${ID_PELLESC})
  set(CMAKE_ASM\${ASM_DIALECT}_COMPILER_ID_VENDOR_FLAGS_${ID_PELLESC} )
  set(CMAKE_ASM\${ASM_DIALECT}_COMPILER_ID_VENDOR_REGEX_${ID_PELLESC} \"Pelles Macro Assembler\")
\n\\2")
set(DetermineASM_rev_match "(\n[ \t]+${ASM_PREV}[ \t]*\n).*#.*patch.*\n([ \t]+${ASM_NEXT}[ \t]*\n)")
set(DetermineASM_rev_replace "\\1\\2")
set(DetermineASM_detect "${ID_PELLESC}")

set(DetermineASM1_module "CMakeDetermineASMCompiler.cmake")
set(DetermineASM1_match "([ \t]*\n[ \t]*)set._CMAKE_PROCESSING_LANGUAGE .ASM..([ \t]*\n[ \t]*include.CMakeFindBinUtils.[ \t]*)")
set(DetermineASM1_replace [=[\1# pellesc-setup patch
set(_CMAKE_PROCESSING_LANGUAGE "ASM${ASM_DIALECT}")\2]=])
set(DetermineASM1_rev_match "([ \t]*\n[ \t]*)#[^\n]*patch[^\n]*\nset._CMAKE_PROCESSING_LANGUAGE .ASM..ASM_DIALECT...([ \t]*\n[ \t]*include.CMakeFindBinUtils.[ \t]*)")
set(DetermineASM1_rev_replace [=[\1set(_CMAKE_PROCESSING_LANGUAGE "ASM")\2]=])
set(DetermineASM1_detect "set.[ \t]*_CMAKE_PROCESSING_LANGUAGE[ \t]+.ASM..ASM_DIALECT")

set(FindBinUtils_module "CMakeFindBinUtils.cmake")
set(FBU_PREV "list.APPEND _CMAKE_TOOL_VARS LINKER AR.[ \t]*\n")  # CMake 3.21
set(FBU_NEXT "elseif..x.{CMAKE_.{_CMAKE_PROCESSING_LANGUAGE}_COMPILER_ID}. MATCHES ..xIAR...")  # CMake 3.22
set(FindBinUtils_match "(\n[ \t]+${FBU_PREV}[ \t]*\n)([ \t]*${FBU_NEXT}[ \t]*\n)")
set(FindBinUtils_replace "\\1
  # pellesc-setup patch
elseif(\"x\${CMAKE_\${_CMAKE_PROCESSING_LANGUAGE}_COMPILER_ID}\" STREQUAL \"x${ID_PELLESC}\")
  set(_CMAKE_LINKER_NAMES \"polink\")
  set(_CMAKE_AR_NAMES \"polib\")
  list(APPEND _CMAKE_TOOL_VARS LINKER AR)
\n\\2")
set(FindBinUtils_rev_match "(\n[ \t]+${FBU_PREV}[ \t]*\n).*#.*patch.*\n([ \t]*${FBU_NEXT}[ \t]*\n)")
set(FindBinUtils_rev_replace "\\1\\2")
set(FindBinUtils_detect "${ID_PELLESC}")
