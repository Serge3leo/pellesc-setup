# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates

include (Platform/Windows-PellesC)
__windows_compiler_pellesc(C)

# TODO set(CMAKE_C_DEPENDS_USE_COMPILER TRUE), can't write depends to file,
# `stdout` only.
