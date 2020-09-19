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

# Long listing of files in $dest to check file sizes.
filesize=$(ls -lh /opt/backup/grafana-19-09-20.tgz | awk '{ print $5}')

# metriks for prometheus
echo "# HELP backup_filename The name of backupfile with date\n# TYPE backup_filename \n" >> /var/lib/node_exporter/textfile_collector/backups.prom
echo backup_filename{group=nodes, type=backup} $filesize >> /var/lib/node_exporter/textfile_collector/backups.prom