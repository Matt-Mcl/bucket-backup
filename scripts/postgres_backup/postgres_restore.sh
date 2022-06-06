#!/bin/bash
# set -x

# Example restore command

date="DATE_OF_BACKUP"

{ # Try
    sudo -u postgres psql < pgdump-$date
} || { # Catch
    echo "Change 'date' the date of the backup file"
    exit 1
}
