HOST=chrome-devtools-host-header
PORT=4444
TARGET=echo-headers

docker build -t $TARGET .

docker run -d \
  --rm \
  --name $TARGET \
  -p $PORT:$PORT \
  $TARGET

echo
echo "Waiting for '$TARGET' container to start"
sleep 4

echo
echo "Adding '$HOST' to /etc/hosts"
echo 127.0.0.1 $HOST | sudo tee -a /etc/hosts

echo
echo "Streaming '$TARGET' container logs"
docker logs -f $TARGET &

echo
echo "Requesting '$HOST' with curl"
curl -H "Host: $HOST" http://$HOST:$PORT

echo
echo "Open your web browser to chrome://inspect, click Configure, add $HOST:$PORT, click Done, inspect $TARGET container output, and observe 'Host: 127.0.0.1' is set instead of 'Host: $HOST'."
echo
echo
