build:
	sudo docker build -t janus-gateway ./
test: 
	sudo docker run -it janus-gateway /bin/bash
