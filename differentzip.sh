#!/bin/bash

# 幫助信息
usage() {
    echo "使用方法：$0 [-o <zip檔案名稱>] [-c1 <commit1>] [-c2 <commit2>] [-h]"
    echo
    echo "選項："
    echo "  -o    指定輸出的 zip 檔案名稱，如果未提供，則使用 'diff.zip'"
    echo "  -c1   指定比較的第一個 commit 點，如果未提供，則使用 'HEAD~1'"
    echo "  -c2   指定比較的第二個 commit 點，如果未提供，則使用 'HEAD'"
    echo "  -h    顯示這條幫助信息"
    echo
    echo "示例："
    echo "  $0 -o changes.zip -c1 a12346 -c2 diu3qa"
    echo "  $0 -o changes.zip"
    echo "  $0 -h"
}

# 初始化默認值
output_zip="diff.zip"
commit1="HEAD~1"
commit2="HEAD"

# 解析命令行參數
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -o) output_zip="$2"; shift ;;
        -c1) commit1="$2"; shift ;;
        -c2) commit2="$2"; shift ;;
        -h) usage; exit 0 ;;
        *) echo "未知參數：$1"; usage; exit 1 ;;
    esac
    shift
done

# 檢查輸出檔案名稱是否以 .zip 結尾，如果不是則添加 .zip
if [[ "$output_zip" != *.zip ]]; then
    output_zip="$output_zip.zip"
fi

# 刪除舊的 zip 檔案（如果存在）
if [ -f "$output_zip" ]; then
    rm "$output_zip"
fi

# 獲取指定提交點之間更改的檔案列表
git diff --name-only "$commit1" "$commit2" | while IFS= read -r file
do
    # 檢查檔案是否存在並排除 .zip 檔案
    if [ -f "$file" ] && [[ "$file" != *.zip ]]; then
        zip -r "$output_zip" "$file"
    fi
done

echo "檔案已壓縮到 $output_zip"
