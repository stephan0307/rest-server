#!/bin/sh

docker build --force-rm                      \
             --tag restic-server:0.13.0 \
       .
docker image prune --force
