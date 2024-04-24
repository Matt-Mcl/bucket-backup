#!/bin/bash

today=`date '+%Y%m%d'`;
directory=$1
bucket_namespace=$2
bucket_region=$3
bucket_name=$4
bucket_dir=$5
home_path=$6
temp_file="envfiles-$today.tar.gz"

# Copy all env files to home_path/envfiles
sudo rm $home_path/envfiles/*
find $home_path -name "*.env" | while read file; do cp "$file" "$home_path/envfiles/$(echo $file | tr '/' '_')"; done

# Create a tar file with all the copied files
tar -czf $temp_file -C $home_path envfiles

source "$directory/venv/bin/activate"

python3 $directory/main.py $2 $3 $4 $5 "$temp_file"

sudo rm $temp_file
