#!/bin/bash
# set -x

if [ -z "$5" ]; then
    echo "Missing variables"
    echo "Run script like so: ./setup.sh {BUCKET_NAMESPACE} {BUCKET_REGION} {BUCKET_NAME} {BUCKET_DIRECTORY} {BACKUP_FILE_PATH} '{CRON_SCHEDULE}'"
    exit
fi

username=$(whoami)
directory="$(pwd)"
script="$directory/backup.sh"
bucket_namespace=$1
bucket_region=$2
bucket_name=$3
bucket_dir=$4
backup_file_path=$5
cron_schedule=$6

if [ ! -d venv ]; then
    echo "venv not present - creating" 
    python3 -m venv venv
    source "venv/bin/activate"

    pip install --upgrade pip
    pip install -r requirements.txt
fi

vars_array=($script $directory $bucket_namespace $bucket_region $bucket_name $bucket_dir $backup_file_path)
vars=${vars_array[@]}

echo "------- Doing initial run ------"
bash $vars
echo "----- Finished initial run -----"

# Delete existing crontabs - means crontab is only present once
sudo crontab -u "$username" -l | grep -v "$vars" | crontab -u "$username" -

# Create crontab to run script
(crontab -l 2>/dev/null; echo "$cron_schedule ${vars[@]}") | crontab -

echo "Created crontab for backups successfully:"
sudo crontab -u "$username" -l | grep "$vars"
