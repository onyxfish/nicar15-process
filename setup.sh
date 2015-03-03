#!/bin/bash

source globals.sh

echo "Creating directories"
mkdir originals

echo "Creating virtualenv"
mkvirtualenv $PROJECT_NAME

echo "Installing requirements"
pip install -r requirements.txt

echo "Downloading data"
curl -L -o $FILENAME https://github.com/onyxfish/journalism/raw/master/examples/realdata/ks_1033_data.csv
