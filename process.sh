#!/bin/bash

source globals.sh

echo "Creating directories"
mkdir temp
mkdir output

echo "Cleaning up old output"
rm temp/*
rm output/*
rm $PROJECT_NAME.db

echo "Activating virtualenv"
workon $PROJECT_NAME

echo "Reducing columns"
csvcut -c county,item_name,quantity,total_cost $FILENAME > temp/reduced.csv

echo "Generating stats > output/stats.txt"
csvstat temp/reduced.csv > output/stats.txt

echo "Creating database"
cat sql/data_create.sql | sqlite3 $PROJECT_NAME.db
echo ".import temp/reduced.csv data" | sqlite3 -csv $PROJECT_NAME.db

echo "Querying 10 most expensive > output/most_expensive.csv"
cat sql/data_most_expensive.sql | sqlite3 -csv $PROJECT_NAME.db > output/most_expensive.csv
