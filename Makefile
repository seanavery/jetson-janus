SHELL := /bin/bash
build:
	sudo docker build -t janus-gateway ./
test: 
	sudo docker run --name=janus-gateway --env-file=.env -p 8088:8088 -p 8089:8089 -p 8188:8188  -p 8080:8080 -it janus-gateway /bin/bash
camera:
	gst-launch-1.0 nvarguscamerasrc ! nvvidconv ! videoconvert ! video/x-raw, format=BGR ! rtpvrawpay ! udpsink host=127.0.0.1 port=5004
clear:
	sudo docker stop janus-gateway
	sudo docker rm janus-gateway
