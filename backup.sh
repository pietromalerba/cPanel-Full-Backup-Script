#!/bin/bash
#############################
# Shellscript backup.
# by @Kikobeats v1.0
#############################

[ $# -ne 2 ] && echo "Use: $0 <relative_path> <max_numbers_backups>" >&2 && exit 1;
echo $2 | grep -qx "[0-9]\+" || { echo " Error. '$2' not is a number " >&2 && exit 1; }
[[ "$1" != /* ]] ||  { echo " Error. '$1' not is a relative path" >&2 && exit 1; }

################
# CONFIG
#################
#
# Max of Backups
MAX_BACKUPS=$2
# PATH Backup folder
BACKUP_FOLDER="$HOME/backups/$1"
[ -d $BACKUP_FOLDER ] || mkdir $BACKUP_FOLDER

# PATH PHP Script
PATH_SCRIPT="$HOME/backups/perform_cpanel_fullbackup.php"
[ ! -e $PATH_SCRIPT ] && echo "Error. wrong PHP Script path (or not exist)." >&2 && exit 1

###################
# DON'T TOUCH MORE!
# #################
#

FILE=(`ls -l $BACKUP_FOLDER | tail -n +2 | tr -s ' ' | cut -d ' ' -f 9| sort -u`)
BACKUPS_EXIST=${#FILE[@]}
COUNT=0

while [ $BACKUPS_EXIST -gt $MAX_BACKUPS ]
do
  echo " Deleting '${FILE[$COUNT]}'..."
  rm $BACKUP_FOLDER/${FILE[$COUNT]}
  let --BACKUPS_EXIST
  let ++COUNT
done

#BACKUP_DATE='mktemp /tmp/backup_date.XXXX'
# exec php script
php -q $PATH_SCRIPT
# move the file to the backup folder
echo " wait the the backup..."; sleep 10m;
find $HOME -type f -name "backup-*" -exec mv {} $BACKUP_FOLDER/ \;
echo " backup is done."
