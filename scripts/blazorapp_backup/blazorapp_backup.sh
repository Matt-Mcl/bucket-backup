#!/bin/bash

today=`date '+%Y%m%d'`;
directory=$1
bucket_namespace=$2
bucket_region=$3
bucket_name=$4
bucket_dir=$5
temp_file="blazorapp-$today.gz"

# Backup /home/ubuntu/blazorapp/data (directory)
sudo tar -czf $temp_file -C /home/ubuntu/blazorapp/data .

source "$directory/venv/bin/activate"

python3 $directory/main.py $2 $3 $4 $5 "$temp_file"

# If the python script has errored, stop start.sh here
if [ $? -ne 0 ]; then
    exit 1
fi

sudo cp $temp_file /mnt/crucial/data/backups/blazorapp.gz
sudo rm $temp_file
