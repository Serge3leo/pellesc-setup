# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates
include_guard ()

macro (__compiler_pellesc lang)
  # CMAKE_${lang}_COMPILE_OPTIONS_WARNING_AS_ERROR, don't have

  set(CMAKE_${lang}_LINK_MODE LINKER)
endmacro ()
