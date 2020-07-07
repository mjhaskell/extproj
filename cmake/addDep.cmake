cmake_minimum_required(VERSION 2.8.3)

function(add_dep CMAKE_IN)
  # parse cmake.in file to get PROJECT, PKG, SRC_DIR, and BIN_DIR
  file(READ ${CMAKE_IN} FILE)
  string(REGEX MATCH "project[(]([A-Za-z0-9_-]+)[ )]" LINE ${FILE})
  set(PROJECT ${CMAKE_MATCH_1})
#  string(REGEX MATCH "GIT_REPOSITORY.*[.]com[/:].*/(.*)[.]git" LINE ${FILE})
#  set(PKG ${CMAKE_MATCH_1})
  string(REGEX MATCH "SOURCE_DIR *..{[A-Z_]+}/([a-z0-9_-]+)" LINE ${FILE})
  set(SRC_DIR ${CMAKE_MATCH_1})
  string(REGEX MATCH "BINARY_DIR *..{[A-Z_]+}/([a-z0-9_-]+)" LINE ${FILE})
  set(BIN_DIR ${CMAKE_MATCH_1})

  # Add external dependency
  set(PKG_DIR ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT})
#  set(PKG_DIR ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-download)
  configure_file("${CMAKE_IN}" "${PKG_DIR}/CMakeLists.txt" IMMEDIATE @ONLY)
  execute_process(COMMAND ${CMAKE_COMMAND}
    -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY ${PKG_DIR}
    )
  execute_process(COMMAND ${CMAKE_COMMAND}
    --build . WORKING_DIRECTORY ${PKG_DIR}
    )

  # Add applicable subdirectories to project
  if(NOT ${SRC_DIR} STREQUAL "" AND EXISTS ${PKG_DIR}/${SRC_DIR})
    add_subdirectory(${PKG_DIR}/${SRC_DIR})
  endif()
  if(NOT ${BIN_DIR} STREQUAL "" AND EXISTS ${PKG_DIR}/${BIN_DIR})
    add_subdirectory(${PKG_DIR}/${BIN_DIR})
  endif()
endfunction()

#function(add_dep cmake_in)
#  set(PKG_DIR ${CMAKE_CURRENT_BINARY_DIR}/${package}-download)
#  configure_file("${in}" "${PKG_DIR}/CMakeLists.txt" IMMEDIATE @ONLY)
#  execute_process(COMMAND ${CMAKE_COMMAND}
#    -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY ${PKG_DIR}
#    )
#  execute_process(COMMAND ${CMAKE_COMMAND}
#    --build . WORKING_DIRECTORY ${PKG_DIR}
#    )

#  file(STRINGS ${in} subdir REGEX " *SOURCE_DIR")


#  add_subdirectory(${PKG_DIR}/${subdir})
#endfunction()

#function(test_dep GIT_URL GIT_TAG)
#  string(REGEX MATCH ".*[.]com[/:].*/(.*)[.]git" GIT_URL ${GIT_URL})
#  set(package ${CMAKE_MATCH_1})
#  message("pkg: ${package}")

#  if (${GIT_URL} MATCHES ".*[.]com[/:].*/(.*)[.]git")
#    set(package ${CMAKE_MATCH_1}) # grab substring saved from (.*)

#    message("match 1: ${CMAKE_MATCH_1}")
#  endif()
#  message("match 1: ${CMAKE_MATCH_1}")
#  string(REGEX MATCH ".*[.]com[/:].*/(.*)[.]git" TEST_PKG ${GIT_URL})
#  message("test: ${TEST_PKG}")

#  string(REGEX REPLACE ".*com.*/" "" PKG ${GIT_URL})
#  string(REGEX REPLACE ".git" "" PKG ${PKG})

#  set(PKG_DIR ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-download)
#  configure_file(cmake/External_Dep.cmake.in "${PKG_DIR}/CMakeLists.txt" IMMEDIATE @ONLY)

#  execute_process(COMMAND ${CMAKE_COMMAND}
#    -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY ${PKG_DIR}
#    )
#  execute_process(COMMAND ${CMAKE_COMMAND}
#    --build . WORKING_DIRECTORY ${PKG_DIR}
#    )

#  add_subdirectory(${PKG_DIR}/${PKG}-src)
#endfunction()

#file(READ cmake/External_Geometry.cmake.in file_)
#file(STRINGS cmake/External_Geometry.cmake.in subdir
#  REGEX " *SOURCE_DIR"
#  )
#string(REGEX REPLACE ".*CMAKE_CURRENT_BINARY_DIR.." "" subdir ${subdir})

#file(STRINGS cmake/External_Geometry.cmake.in proj
#  REGEX "project\\(?"
#  )
#string(REPLACE "project(" "" proj ${proj})
#message("proj: ${proj}")
#string(FIND ${proj} " " end)
#string(SUBSTRING ${proj} 0 ${end} proj)

#message("file: ${file_}")
#message("subdir: ${subdir}")
#message("proj: ${proj}")

#string(FIND ${file_} "SOURCE_DIR" beg)
#message("beg: ${beg}")

#include(cmake/addDep.cmake)
#add_dep(geometry External_Geometry.cmake.in geometry-src)

#message("geom inc dirs: " ${geometry_INCLUDE_DIRS})
#message("geom libs: " ${geometry_LIBRARIES})
