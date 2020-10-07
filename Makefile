SHELL := /bin/bash
build:
	sudo docker build -t janus-gateway ./
test: 
	echo $(CURDIR)
	sudo docker run --name=janus-gateway --env-file=.env -it janus-gateway /bin/bash
# -v $(CURDIR)/janus:/janus
clear:
	sudo docker stop janus-gateway
	sudo docker rm janus-gateway
