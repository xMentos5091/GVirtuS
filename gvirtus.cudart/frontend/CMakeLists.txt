cmake_minimum_required(VERSION 3.10.2)
project(cudart)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -fPIC")
set(CMAKE_CXX_STANDARD 17)

message(${CMAKE_INSTALL_PREFIX})
get_filename_component(PARENT_DIR ../ ABSOLUTE)
include_directories(SYSTEM ${PARENT_DIR})
include_directories(SYSTEM ${CMAKE_SOURCE_DIR}/include)
include_directories(SYSTEM ${CMAKE_INSTALL_PREFIX}/include/gvirtus)
include_directories(SYSTEM ${CMAKE_INSTALL_PREFIX}/include/gvirtus.cudautil)

set(frontend_SOURCE ${CMAKE_SOURCE_DIR}/include/CudaRt.h
                      ${CMAKE_SOURCE_DIR}/src/CudaRt.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRtFrontend.cpp
                      ${CMAKE_SOURCE_DIR}/include/CudaRtFrontend.h
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_device.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_error.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_event.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_execution.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_opengl.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_internal.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_memory.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_stream.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_surface.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_texture.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_thread.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_version.cpp
                      ${CMAKE_SOURCE_DIR}/src/CudaRt_occupancy.cpp
)

add_library(gvirtus-frontend SHARED IMPORTED)
set_target_properties(gvirtus-frontend PROPERTIES IMPORTED_LOCATION ${CMAKE_INSTALL_PREFIX}/lib/libgvirtus-frontend.so )

add_library(${PROJECT_NAME} SHARED ${frontend_SOURCE})
add_library(cudart-static STATIC ${frontend_SOURCE})
set_target_properties(cudart-static PROPERTIES OUTPUT_NAME cudart)
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/frontend)
install(TARGETS cudart-static DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/frontend)
target_link_libraries(${PROJECT_NAME} "-Wl,--whole-archive ${CMAKE_INSTALL_PREFIX}/lib/frontend/libcudautil.a -Wl,--no-whole-archive" gvirtus-frontend rt log4cplus)