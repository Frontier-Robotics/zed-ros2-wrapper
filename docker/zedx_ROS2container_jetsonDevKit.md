
## Pre-compilation/build steps
1. Make sure to download the camera calibration file from stereolabs website. This is required especially when running the ROS driver via docker container. Once you've downloaded the file, make sure to place it in a directory of the host PC that is meant to be mounted inside the docker container.
For the remaining steps in this guide the file is mounted in */home/frontier/Documents/ZED/settings*
To download the calibration file please follow the instructions described [here](https://support.stereolabs.com/hc/en-us/articles/21614848880791-How-can-I-use-the-ZED-with-Docker-on-a-robot-with-no-internet-connection) 

### Note:
The following steps assume that we are building a container for a nvidia jetson Orin with l4t35.1 installed. A working configuration of the container was found by running **l4t35.2 as the container base OS + zed SDK 4.0.8**

## Setup
1. Clone the zed-ros2-wrapper forked repo and checkout the branch *auip2_zedx*
2. Build the docker image with the corresponding Dockerfile. For this purpose a compose file compose.yaml is provided on the root of the repo. To start the build process run
```bash
docker-compose -f compose.yaml build
```

## Execution
1. Start a docker container with the image built in the previous step. For a correct configuration of the environment multiple options are required for the docker run command, hence a bash script is provided in the *docker* directory to simplify this process. 
```bash
./run.bash
```
The container started using this script is configured as to continuosly run in the background at system boot and automatically launch the zedx ROS2 camera node (via launch file) as defiend via its entrypoint; it usually takes a couple of mins after a reboot for the process to start.

## Post-execution configuration
After the camera node is running and the image msgs are published, it is important to **change the default DDS implementation used by ROS2 to cyclone-dds** for all bash sessions where a topic listener to the corresponding topics from the zed ROS driver is started. For this please run the following commands:
```bash
sudo apt install ros-humble-rmw-cyclonedds-cpp
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp 
```



