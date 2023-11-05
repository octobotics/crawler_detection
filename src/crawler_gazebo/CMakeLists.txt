cmake_minimum_required(VERSION 2.8.3)

project(crawler_gazebo)

find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  geometry_msgs
)

catkin_package()

catkin_install_python(PROGRAMS
   src/keyboard_teleop.py
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

find_package(roslaunch)

foreach(dir config launch meshes urdf)
	install(DIRECTORY ${dir}/
		DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach(dir)