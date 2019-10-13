#!/usr/bin/env bash

set -e

USER=app
GROUP=$USER
APP_PATH=/home/app

chown $USER:$GROUP -R $APP_PATH


echo "Completed!"