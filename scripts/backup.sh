#!/bin/bash

if [ -z "$1" ] || [ ! -d "$1" ]; then
    echo "Lỗi: Tham số không hợp lệ hoặc thư mục không tồn tại!"
    echo "Cú pháp: $0 <đường_dẫn_thư_mục>"
    exit 1
fi

TARGET_DIR=$(realpath "$1")
FOLDER_NAME=$(basename "$TARGET_DIR")
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/backup"
BACKUP_FILE="$BACKUP_DIR/${FOLDER_NAME}_${TIMESTAMP}.tar.gz"
LOG_FILE="$HOME/dg1_2412111062/logs/backup.log"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" -C "$(dirname "$TARGET_DIR")" "$FOLDER_NAME"

if [ $? -eq 0 ]; then
    LOG_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$LOG_TIME] Created: $BACKUP_FILE" >> "$LOG_FILE"
    echo "Đã sao lưu thành công vào: $BACKUP_FILE"
    exit 0
else
    echo "Lỗi: Quá trình sao lưu thất bại!"
    exit 2
fi
