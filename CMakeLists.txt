cmake_minimum_required(VERSION 2.8.3)
project(extproj)

## James's method
include(ExternalProject)
include(cmake/External_Eigen3.cmake)
message("Eigen dirs: ${EIGEN3_INCLUDE_DIRS}")

include(cmake/External_Geometry.cmake.in)
message("Geometry dirs: ${GEOMETRY_INCLUDE_DIRS}")

## Parker's method
#set(geom_DIR ${CMAKE_CURRENT_BINARY_DIR}/geometry-download)
#configure_file("cmake/External_Geometry.cmake.in" "${geom_DIR}/CMakeLists.txt" @ONLY)
#execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" . WORKING_DIRECTORY ${geom_DIR})
#execute_process(COMMAND ${CMAKE_COMMAND} --build . WORKING_DIRECTORY ${geom_DIR})
#add_subdirectory(${geom_DIR}/geometry-src)

## my custom function to do Parker's method
#include(cmake/addDep.cmake)
#add_dep(cmake/External_Geometry.cmake.in)

include_directories(
  include
  ${EIGEN3_INCLUDE_DIRS}
  ${GEOMETRY_INCLUDE_DIRS}
  )

add_executable(extproj
  src/main.cpp
  )
#add_dependencies(extproj eigen geometry) # eigen/geometry DNE
target_link_libraries(extproj 
#    geometry # use with Parker's method
    )

