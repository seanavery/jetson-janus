SHELL := /bin/bash
build:
	sudo docker build -t janus-gateway ./
test: 
	echo $(CURDIR)
	sudo docker run --name=janus-gateway --env-file=.env -it janus-gateway /bin/bash
# -v $(CURDIR)/janus:/janus
camera:
	gst-launch-1.0 nvarguscamerasrc ! nvvidconv ! videoconvert ! video/x-raw, format=BGR ! rtpvrawpay ! udpsink host=127.0.0.1 port=5200
clear:
	sudo docker stop janus-gateway
	sudo docker rm janus-gateway
