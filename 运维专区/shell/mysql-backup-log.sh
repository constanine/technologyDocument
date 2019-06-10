#! /bin/bash

. $HOME/.profile
echo $HOME
# shell options
set -o nounset
set -o errexit
set -x

export BACKUP_DB_NAME=xxx #需要备份的数据库库名
TIMESTAMP=$(date +%Y%m%d.%H%M%S)

#LOG_FOLDER 为环境变量中定义的执行日志存放地址
LOG_FILE="$LOG_FOLDER/mysqldatabackup-$TIMESTAMP.log"

echo "Run [$*] at $TIMESTAMP , with log file $LOG_FILE ..."

echo -e "\n" >> "$LOG_FILE"
echo "********************************************************************************" >> "$LOG_FILE"
echo "*                                                                              *" >> "$LOG_FILE"
echo "*  Begin to run [mysqldump] ..."                                                  >> "$LOG_FILE"
echo "*   - User    : `whoami`"                                                         >> "$LOG_FILE"
echo "*   - Time    : `date`"                                                           >> "$LOG_FILE"
echo "*   - Log file: $LOG_FILE"                                                        >> "$LOG_FILE"
echo "*                                                                              *" >> "$LOG_FILE"
echo "********************************************************************************" >> "$LOG_FILE"
echo -e "\n" >> "$LOG_FILE"

./mysql-backup-core.sh $BACKUP_DB_NAME

set +x
echo -e "\n" >> "$LOG_FILE"
echo "********************************************************************************" >> "$LOG_FILE"
echo "*                                                                              *" >> "$LOG_FILE"
echo "*  Run [mysql-backup] completed, `date`."                                        >> "$LOG_FILE"
echo "*                                                                              *" >> "$LOG_FILE"
echo "********************************************************************************" >> "$LOG_FILE"
echo -e "\n\n\n" >> "$LOG_FILE"

