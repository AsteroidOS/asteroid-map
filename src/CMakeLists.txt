add_library(asteroid-map main.cpp resources.qrc)
set_target_properties(asteroid-map PROPERTIES PREFIX "")

target_link_libraries(
	asteroid-map
	PUBLIC
		Asteroid::AsteroidApp6
)

install(
	TARGETS asteroid-map
	DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
