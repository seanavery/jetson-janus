SHELL := /bin/bash
build:
	sudo docker build -t janus-gateway ./
test: 
	sudo docker run --name=janus-gateway --env-file=.env --network="host" -p 8088:8088 -p 8089:8089 -p 8188:8188  -p 8080:8080 -it janus-gateway /bin/bash
camera:
	gst-launch-1.0 -e nvarguscamerasrc ! 'video/x-raw(memory:NVMM), width=1920, height=1080, framerate=30/1' ! nvv4l2h264enc bitrate=8000000 insert-sps-pps=true ! rtph264pay config-interval=1 pt=96 mtu=1400 ! udpsink host=192.168.1.2 port=5000 sync=false async=false
display:
	gst-launch-1.0 udpsrc port=5000 ! application/x-rtp,encoding-name=H264,payload=96 ! rtph264depay ! h264parse ! queue ! avdec_h264 ! xvimagesink sync=false async=false -e
clear:
	sudo docker stop janus-gateway
	sudo docker rm janus-gateway
