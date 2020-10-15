# jetson-janus

## why?

Jetson devices come with great primitives for camera capture and RTP streaming. However, what if you want to stream directly to a browser? 

[Janus]() is a modular and slim C webrtc gateway, allowing browser based streaming with low overhead. This codebase is a docker wrapper around Janus written specificly for Jetson devices. 

## run

`
# build docker container locally
make build
`

`
# run docker container
make test
`

`
# run camera to rtp producer
make camera
`

```
1. The container exposes a webserver for the streaming plugin app at port 8080
2. Janus is spawned with normal http endpoints
