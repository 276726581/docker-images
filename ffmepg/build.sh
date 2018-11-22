#!/bin/sh

docker build -t ffmpeg .
docker run --rm -v $(pwd):/out ffmpeg cp /usr/local/bin/ffmpeg /out

