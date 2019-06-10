#! /bin/bash

. $HOME/.profile
# shell options
set -o nounset
set -o errexit
set -x

#ARCHIVE_DATE 为环境变量中定义的归档日期

TIMESTAMP=$(date +%Y%m%d.%H%M%S)
POOL_NUM=$(date +%d%p)

TO_ARCHIVE=0
#manaul archiveFile
if [[ "${ARCHIVE_DATE}" = "$(date +%d)" || "15" = "$(date +%d)" ]];then
	TO_ARCHIVE=1
fi

MYSQL_ARGS="--add-drop-table -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} --host=${MYSQL_SERVER_HOST} --port=${MYSQL_SERVER_PORT}"

#BACKUP_DIR 为环境变量中定义的数据备份存放地址
DAILY_BACKUP_DIR="${BACKUP_DIR}/daily"
mkdir -pv ${DAILY_BACKUP_DIR}

doBackup() {
    BACKUP_FILE="${DAILY_BACKUP_DIR}/$1-${POOL_NUM}.sql"
    mysqldump ${MYSQL_ARGS} $1 > "${BACKUP_FILE}"
    rm -fv "${BACKUP_FILE}.gz"
    gzip -v "${BACKUP_FILE}"

    if [[ "1" = "${TO_ARCHIVE}" ]];then
        ARCH_BACKUP_DIR="${BACKUP_DIR}/archive/${TIMESTAMP}"
        mkdir -pv ${ARCH_BACKUP_DIR}
        cp -v "${BACKUP_FILE}.gz" "${ARCH_BACKUP_DIR}"
    fi
}

doBackup $1

