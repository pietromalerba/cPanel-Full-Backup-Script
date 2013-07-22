#!/bin/bash
#############################
# Shellscript backup. CHMOD  700.
# by @Kikobeats v1.0
#############################

[ $# -ne 1 ] && echo "Error. Only need 1 arguments (path where save the backup)." >&2 && exit 1

################
# CONFIG
#################
#
# Max of Backups
MAX_BACKUPS=5
# PATH Backup folder
BACKUP_FOLDER="$HOME/backups/$1"
# PATH PHP Script
PATH_SCRIPT="$HOME/backups/perform_cpanel_fullbackup.php"
[ ! -e $PATH_SCRIPT ] && echo "Error. wrong PHP Script path (or not exist)." >&2 && exit 1

###################
# DON'T TOUCH MORE!
# #################
#
# check folders for backups exists
[ -d $BACKUP_FOLDER ] || mkdir $BACKUP_FOLDER
#
# check number of backups is correct
N_BACKUPS=`ls -l $BACKUP_FOLDER | wc -l`
let N_BACKUPS=$N_BACKUPS-1
N_BACKUPS=`ls -l $BACKUP_FOLDER | tail -n $N_BACKUPS | wc -l`

  while [ $N_BACKUPS -gt $MAX_BACKUPS ]
  do
    FIRST_FILE=`ls -l $BACKUP_FOLDER | head -2 | tail -1 | tr -s ' ' | cut -d ' ' -f 9`
    rm $BACKUP_FOLDER/$FIRST_FILE
    #echo "Delete the file $FIRST_FILE"
    let N_BACKUPS=$N_BACKUPS-1
  done

# exec php script
php -q $PATH_SCRIPT

# move the file to the backup folder
echo "backup is coming"
sleep 10m
find . -type f -name "backup-*" -cmin 1 -exec mv {} $BACKUP_FOLDER/ \;
echo "backup is done"
