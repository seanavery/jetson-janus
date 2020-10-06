SHELL := /bin/bash
build:
	sudo docker build -t janus-gateway ./
test: 
	echo $(CURDIR)
	sudo docker run --name=janus-gateway -v $(CURDIR)/janus:/janus -it janus-gateway /bin/bash
