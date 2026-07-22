cmake_minimum_required(VERSION 3.6.0)

project(
	asteroid-map
	VERSION 2.1.0
	DESCRIPTION "Map app for AsteroidOS"
)

find_package(ECM REQUIRED NO_MODULE)
find_package(AsteroidApp6 REQUIRED)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ASTEROID_MODULE_PATH})

include(FeatureSummary)
include(GNUInstallDirs)
include(ECMFindQmlModule)
include(Asteroid6CMakeSettings)
include(Asteroid6Translations)

ecm_find_qmlmodule(Nemo.Configuration 1.0)

add_subdirectory(src)
add_subdirectory(icons)

build_translations(i18n)
generate_desktop(${CMAKE_SOURCE_DIR} asteroid-map)

configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/asteroid-map.in
        ${CMAKE_BINARY_DIR}/asteroid-map
        @ONLY
)

install(
        PROGRAMS ${CMAKE_BINARY_DIR}/asteroid-map
        DESTINATION ${CMAKE_INSTALL_BINDIR}
)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
