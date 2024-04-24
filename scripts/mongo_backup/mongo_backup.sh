#!/bin/bash

today=`date '+%Y%m%d'`;
directory=$1
bucket_namespace=$2
bucket_region=$3
bucket_name=$4
bucket_dir=$5
temp_folder="mongodump-$today"

mongodump --quiet --out $temp_folder

# Remove dev database
sudo rm -rf "$temp_folder/django_workoutapp_dev/"

tar rvf "$temp_folder.tar" $temp_folder > /dev/null

source "$directory/venv/bin/activate"

python3 $directory/main.py $2 $3 $4 $5 "$temp_folder.tar"

# If the python script has errored, stop start.sh here
if [ $? -ne 0 ]; then
    exit 1
fi

sudo rm -rf $temp_folder
sudo rm "$temp_folder.tar"
