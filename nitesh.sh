#!/bin/bash

pwd
docker --version
docker images
docker ps
docker build -t niteshsen/pipeline:apache3 .
docker run -d -p 8080:80  niteshsen/pipeline:apache3
