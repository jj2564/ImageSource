#!/bin/bash

# 預設源目錄和目的文件名
SOURCE_DIR="images"
DESTINATION_FILE="all.zip"

# 解析命令行參數
while getopts ":o:" opt; do
  case $opt in
    o)
      DESTINATION_FILE="$OPTARG"
      # 檢查文件名是否以 .zip 結尾，如果不是則添加
      if [[ $DESTINATION_FILE != *.zip ]]; then
        DESTINATION_FILE="${DESTINATION_FILE}.zip"
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# 創建 ZIP 文件，排除 __MACOSX 文件夾
zip -r "${DESTINATION_FILE}" "${SOURCE_DIR}" -x "*__MACOSX*"

echo "Created ${DESTINATION_FILE} from ${SOURCE_DIR}"
