xhost +local:
sudo docker run -it --rm \
  --name profanity \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home/wes/lich:/home/lich \
  profanity:v1.1