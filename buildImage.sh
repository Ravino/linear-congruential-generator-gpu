#!/bin/bash

#name image 
nameImageg="cuda-runtime
#build image without cache layers
docker build --no-cache -t $nameImage ./
