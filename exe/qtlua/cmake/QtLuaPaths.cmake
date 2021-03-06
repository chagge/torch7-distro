SET(QtLua_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

SET(QtLua_INSTALL_BIN_SUBDIR "bin" CACHE PATH
  "Install dir for binaries (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_LIB_SUBDIR "lib" CACHE PATH
  "Install dir for archives (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_INCLUDE_SUBDIR "include" CACHE PATH
  "Install dir for include (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_CMAKE_SUBDIR "share/lua/cmake" CACHE PATH
  "Install dir for .cmake files (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_LUA_PATH_SUBDIR "share/lua/5.1" CACHE PATH
  "Install dir for QtLua packages files (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_LUA_CPATH_SUBDIR "lib/lua/5.1" CACHE PATH
  "Install dir for QtLua C packages files (relative to QtLua_INSTALL_PREFIX)")

SET(QtLua_INSTALL_FINDLUA_DIR "${QtLua_BINARY_DIR}/cmake")
SET(QtLua_INSTALL_BIN "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_BIN_SUBDIR}")
SET(QtLua_INSTALL_LIB "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_LIB_SUBDIR}")
SET(QtLua_INSTALL_INCLUDE "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_INCLUDE_SUBDIR}")
SET(QtLua_INSTALL_CMAKE "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_CMAKE_SUBDIR}")
SET(QtLua_INSTALL_LUA_PATH "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_LUA_PATH_SUBDIR}")
SET(QtLua_INSTALL_LUA_CPATH "${QtLua_INSTALL_PREFIX}/${QtLua_INSTALL_LUA_CPATH_SUBDIR}")

# reverse relative path to prefix (ridbus is the palindrom of subdir)
FILE(RELATIVE_PATH QtLua_INSTALL_BIN_RIDBUS "${QtLua_INSTALL_BIN}" "${QtLua_INSTALL_PREFIX}/.")
FILE(RELATIVE_PATH QtLua_INSTALL_CMAKE_RIDBUS "${QtLua_INSTALL_CMAKE}" "${QtLua_INSTALL_PREFIX}/.")
GET_FILENAME_COMPONENT(QtLua_INSTALL_BIN_RIDBUS "${QtLua_INSTALL_BIN_RIDBUS}" PATH)
GET_FILENAME_COMPONENT(QtLua_INSTALL_CMAKE_RIDBUS "${QtLua_INSTALL_CMAKE_RIDBUS}" PATH)

IF(UNIX)
  OPTION(QtLua_BUILD_WITH_RPATH "Build libraries with rpaths" ON)

  IF(QtLua_BUILD_WITH_RPATH)
    SET(CMAKE_SKIP_BUILD_RPATH FALSE)
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 
    SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
    FILE(RELATIVE_PATH QtLua_INSTALL_BIN2LIB 
      "${QtLua_INSTALL_BIN}" "${QtLua_INSTALL_LIB}")
    FILE(RELATIVE_PATH QtLua_INSTALL_BIN2CPATH 
      "${QtLua_INSTALL_BIN}" "${QtLua_INSTALL_LUA_CPATH}")
    IF(NOT APPLE) 
      OPTION(WITH_DYNAMIC_RPATH 
        "Build libraries with executable relative rpaths (\$ORIGIN)" ON )
    ENDIF(NOT APPLE)
    IF (WITH_DYNAMIC_RPATH OR APPLE)
      SET(CMAKE_INSTALL_RPATH "\$ORIGIN/${QtLua_INSTALL_BIN2LIB}")
    ELSE (WITH_DYNAMIC_RPATH OR APPLE)
      SET(CMAKE_INSTALL_RPATH "${QtLua_INSTALL_LIB}")
    ENDIF (WITH_DYNAMIC_RPATH OR APPLE)
    SET(CMAKE_INSTALL_NAME_DIR "@executable_path/${QtLua_INSTALL_BIN2LIB}")
  ENDIF(QtLua_BUILD_WITH_RPATH)

ENDIF(UNIX)

IF (WIN32)
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
ENDIF (WIN32)
