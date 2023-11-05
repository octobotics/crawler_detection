#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ws/crawler_detection/src/detectron2_ros"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ws/crawler_detection/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ws/crawler_detection/install/lib/python3/dist-packages:/home/ws/crawler_detection/build/detectron2ros/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ws/crawler_detection/build/detectron2ros" \
    "/usr/bin/python3" \
    "/home/ws/crawler_detection/src/detectron2_ros/setup.py" \
     \
    build --build-base "/home/ws/crawler_detection/build/detectron2ros" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ws/crawler_detection/install" --install-scripts="/home/ws/crawler_detection/install/bin"
