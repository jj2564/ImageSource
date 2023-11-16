#!/bin/bash

# 檢查是否提供了版本號
if [ -z "$1" ]; then
    echo "Usage: $0 version_number"
    exit 1
fi

VERSION=$1
SOURCE_DIR="images"
DESTINATION_FILE="${VERSION}.zip"

# 創建 ZIP 文件，排除 __MACOSX 文件夾
zip -r "${DESTINATION_FILE}" "${SOURCE_DIR}" -x "*__MACOSX*"

echo "Created ${DESTINATION_FILE} from ${SOURCE_DIR}"
