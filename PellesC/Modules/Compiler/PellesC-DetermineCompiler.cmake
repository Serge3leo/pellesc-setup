# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

# Pelles C bug warning, if failed first detection iteration
string(TOLOWER "${CMAKE_C_COMPILER}" _pellesc_lower_)
if (WIN32 AND "${_pellesc_lower_}" MATCHES "pelles.*c.*bin.*cc"
    AND "${_pellesc_lower_}" MATCHES " "
    AND NOT "x${testflags}" STREQUAL "x")
  message("WARNING: PellesC have space in \"${CMAKE_C_COMPILER}\","
          " use -DCMAKE_C_COMPILER=pocc or"
          " SFN: <DRIVE>:\\PROGRA~1\\PellesC\\Bin... in PATH")
endif ()

set(_compiler_id_pp_test "defined(__POCC__)")

set(_compiler_id_version_compute "
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_DEC@(__POCC__/100)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_DEC@(__POCC__%100)")
