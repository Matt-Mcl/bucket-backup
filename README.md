# Bucket Backup

Simply run [setup.sh](setup.sh) like so:

`./setup.sh {BACKUP_SCRIPT_NAME} '{CRON_SCHEDULE}' {BUCKET_NAMESPACE} {BUCKET_REGION} {BUCKET_NAME} {BUCKET_DIRECTORY} {BACKUP_FILE_PATH}"`

Example:

`./setup.sh backup.sh '0 * * * *' abcdefghij123 re-region-1 my-bucket bucket-folder /home/ubuntu/database`

This would backup the file `/home/ubuntu/database` to the bucket `my-bucket` under the `bucket-folder` directory every hour.

Notes: 
- `{BACKUP_SCRIPT_NAME}` should be set to `backup.sh` when simply backing up a file. It can instead be something from the [scripts](scripts) folder if you want to backup custom things.
- Quotes are needed around the cron schedule.
