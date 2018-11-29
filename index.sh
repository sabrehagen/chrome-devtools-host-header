#!/bin/bash

HOST=chrome-devtools-host-header
PORT=4444
TARGET=echo-headers

BOLD_GREEN="$(tput bold) $(tput setaf 2)"
RESET_COLOR=$(tput sgr0)

echo
echo "$BOLD_GREEN Building '$TARGET' container...$RESET_COLOR"
sleep 4

docker build -t $TARGET .

docker run -d \
  --rm \
  --name $TARGET \
  -p $PORT:$PORT \
  $TARGET

echo
echo "$BOLD_GREEN Waiting for '$TARGET' container to start...$RESET_COLOR"
sleep 4

echo
echo "$BOLD_GREEN Adding '$HOST' to /etc/hosts...$RESET_COLOR"
echo 127.0.0.1 $HOST | sudo tee -a /etc/hosts

echo
echo "$BOLD_GREEN Streaming '$TARGET' container logs...$RESET_COLOR"
docker logs -f $TARGET &

echo
echo "$BOLD_GREEN Requesting '$HOST' with curl...$RESET_COLOR"
curl -H "Host: $HOST" http://$HOST:$PORT

echo
echo "$BOLD_GREEN Open your web browser to chrome://inspect, click Configure, add $HOST:$PORT, click Done, and observe in the output below 'Host: 127.0.0.1' is set instead of 'Host: $HOST'.$RESET_COLOR"
echo
echo
