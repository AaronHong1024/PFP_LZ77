# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BUILD_SOURCE_DIRS "/Users/yuhong/CLionProjects/PFP_LZ77-master;/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system")
set(CPACK_CMAKE_GENERATOR "Unix Makefiles")
set(CPACK_COMPONENTS_GROUPING "ALL_COMPONENTS_IN_ONE")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEBIAN_FILE_NAME "DEB-DEFAULT")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Massimiliano Rossi")
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS "ON")
set(CPACK_DEB_COMPONENT_INSTALL "YES")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "/Applications/CLion.app/Contents/bin/cmake/mac/share/cmake-3.20/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "pfp-cst built using CMake")
set(CPACK_GENERATOR "STGZ;TGZ;DEB")
set(CPACK_INSTALL_CMAKE_PROJECTS "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system;pfp-cst;ALL;/")
set(CPACK_INSTALL_PREFIX "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/install")
set(CPACK_MODULE_PATH "/Users/yuhong/CLionProjects/PFP_LZ77-master/CMakeModules")
set(CPACK_NSIS_DISPLAY_NAME "pfp-cst 0.1.0")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
set(CPACK_NSIS_PACKAGE_NAME "pfp-cst 0.1.0")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.1.sdk")
set(CPACK_OUTPUT_CONFIG_FILE "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CPackConfig.cmake")
set(CPACK_PACKAGE_CONTACT "rossi.m@ufl.edu")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "/Applications/CLion.app/Contents/bin/cmake/mac/share/cmake-3.20/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "PFP-CST")
set(CPACK_PACKAGE_FILE_NAME "pfp-cst-0.1.0-Darwin")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "pfp-cst 0.1.0")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "pfp-cst 0.1.0")
set(CPACK_PACKAGE_NAME "pfp-cst")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "University of Florida")
set(CPACK_PACKAGE_VERSION "0.1.0")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "1")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_RESOURCE_FILE_LICENSE "/Users/yuhong/CLionProjects/PFP_LZ77-master/LICENSE")
set(CPACK_RESOURCE_FILE_README "/Users/yuhong/CLionProjects/PFP_LZ77-master/README.md")
set(CPACK_RESOURCE_FILE_WELCOME "/Applications/CLion.app/Contents/bin/cmake/mac/share/cmake-3.20/Templates/CPack.GenericWelcome.txt")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CPackSourceConfig.cmake")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "pfp-cst-sources")
set(CPACK_SYSTEM_NAME "Darwin")
set(CPACK_THREADS "1")
set(CPACK_TOPLEVEL_TAG "Darwin")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
