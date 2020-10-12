# run janus server in the background
./janus/janus &
# run webserver
cd /janus/html && python3 -m http.server 8080
