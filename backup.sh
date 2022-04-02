#!/bin/bash
# set -x

today=`date '+%Y%m%d'`;
directory=$1
bucket_namespace=$2
bucket_region=$3
bucket_name=$4
bucket_dir=$5
backup_file_path=$6
temp_file="/tmp/$(basename $backup_file_path)-$today"

sudo cp $backup_file_path $temp_file

source "$directory/venv/bin/activate"

python3 $directory/main.py $2 $3 $4 $5 $temp_file

# If the python script has errored, stop start.sh here
if [ $? -ne 0 ]; then
    exit 1
fi


sudo rm $temp_file
