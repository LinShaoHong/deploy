#!/bin/bash

docker container ls -q | xargs docker container stop
