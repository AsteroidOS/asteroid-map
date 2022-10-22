add_library(asteroid-map main.cpp resources.qrc)
set_target_properties(asteroid-map PROPERTIES PREFIX "" SUFFIX "")

target_link_libraries(asteroid-map PUBLIC
	AsteroidApp)

install(TARGETS asteroid-map
	DESTINATION ${CMAKE_INSTALL_BINDIR})
