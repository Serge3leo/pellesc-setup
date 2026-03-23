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
