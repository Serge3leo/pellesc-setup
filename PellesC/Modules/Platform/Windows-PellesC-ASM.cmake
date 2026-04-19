# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates

include (Platform/Windows-PellesC)
__windows_compiler_pellesc(ASM)

set(CMAKE_ASM_SOURCE_FILE_EXTENSIONS s;S;asm)
