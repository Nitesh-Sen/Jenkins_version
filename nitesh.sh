#!/bin/bash

pwd
echo pwd
docker --version
echo dockerversion
docker images
echo dockerimages
docker ps
echo dockerps
pwd
ls -lhtr
docker build -t niteshsen/pipeline:apache3 .
docker run -d -p 8080:80  niteshsen/pipeline:apache3
