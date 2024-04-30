#!/usr/bin/env bash

image_name=auip2_l4t35_2_frontier 
container_name=auip2_zedx

docker run -it --runtime nvidia -it --privileged --net=host --ipc=host --pid=host -e NVIDIA_DRIVER_CAPABILITIES=all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/argus_socket:/tmp/argus_socket -v /var/nvidia/nvcam/settings/:/var/nvidia/nvcam/settings/ -v /etc/systemd/system:/etc/systemd/system -v /dev:/dev -v /home/frontier/Documents/ZED/settings:/usr/local/zed/settings --restart unless-stopped --name $container_name $image_name
