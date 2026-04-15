#!/usr/bin/env sh

# Default C/C++ compilers
if has "clang"; then

  # Clang Compiler
  var "CC" "$(command -v clang)"

  # Clang++ Compiler
  var "CXX" "${CC}++"

  # C-Family Preprocessor
  var "CPP" "${CC}-cpp"

  var "HAS_CLANG" 1

# Fallback to gcc if it exists.
elif has "gcc"; then

  # GCC Compiler
  var "CC" "$(command -v gcc)"

  # G++ Compiler
  var "CXX" "${CC}++"

  # GCC Preprocessor
  var "CPP" "$(command -v cpp)"

  var "HAS_GCC" 1

else
  err "unable to find default C compiler."
  return 1
fi

# Default Compiler Options
var "CFLAGS" "-Wall -std=gnu17"
var "CXXFLAGS" "-Wall -std=gnu++14"
var "CPPFLAGS" "-Wall"

# Set the version of the default compiler.
if [ -n "$HAS_CLANG" ]; then
  var "CLANG_VERSION" "$(clang --version | awk 'NR==1 { print $3 }')"
#	var "CLANG_INCLUDE_PATH" "/usr/lib/clang/${CLANG_VERSION}/include"
fi

if [ -n "$HAS_GCC" ]; then
  var "GCC_VERSION" "$(gcc --version | head -n 1 | cut -d' ' -f3)"
  var "GCC_INCLUDE_PATH" "/usr/lib/gcc/${GCC_VERSION}/include"
fi

# Headers

# Libraries
# LD_LIBRARY_PATH and LD_PRELOAD should almost always never be set in scripts.
# var "LD_LIBRARY_PATH" "/usr/local/lib:/usr/lib"
# var "LD_PRELOAD" ""
#
# Searched after any paths given with -I on command line.
# Used regardless of the language being preprocessed.
var "CPATH" ":src"

# Search paths only used for the specified language.
var "C_INCLUDE_PATH" ":/usr/local/include:/usr/include"

# Use -stdlib= libc++ for clang++ or libstdc++ for g++ c++ library.
#var "CPLUS_INCLUDE_PATH" ":/usr/local/include:/usr/include/c++/${GCC_VERSION}:/usr/include"
#var "OBJC_INCLUDE_PATH" "/usr/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/include/objc"

# Packages
var "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/lib/pkgconfig"