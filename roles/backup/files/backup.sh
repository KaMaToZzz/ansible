#!/bin/bash

# What to backup.
backup_files="/home /etc"

# Where to backup to.
dest="/opt/backup"

# Create archive filename.
day=$(date +%d-%m-%y)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Long listing of files in $filesize to check file sizes.
filesize=$(du -k "$dest/$archive_file" | cut -f1)

# metriks for prometheus
(echo -e '# HELP backup_filesize The name of backupfile with size\n# TYPE backup_filesize') > /var/lib/node_exporter/textfile_collector/backups.prom
(echo 'backup_filesize{group="nodes", type="backup"}' $filesize) >> /var/lib/node_exporter/textfile_collector/backups.prom