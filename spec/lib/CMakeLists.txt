# CMake version.
cmake_minimum_required(VERSION 2.8)

# Project name.
project(sample C)

# Create shared library.
add_library(sample SHARED sample.c)

if (APPLE)
    set_property(TARGET sample PROPERTY PREFIX "lib")
    set_property(TARGET sample PROPERTY OUTPUT_NAME "sample.so")
    set_property(TARGET sample PROPERTY SUFFIX "")
endif()
