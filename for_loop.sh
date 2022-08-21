#!/bin/bash

# 基本形
# for f in file1 file2 file3 file4 file5; do
#   cp -p "${f}" "${f}.$(date +%Y%m%d)"
# done


# 変数にまとめるバージョン
# files='file1 file2 file3 file4 file5'
# for f in ${files}; do # ここのfiles変数はダブルコーテーションで囲まない
#   cp -p "${f}" "${f}.$(date +%Y%m%d)"
# done


# 変数にまとめるバージョン（改行）
files='file1
       file2
       file3
       file4
       file5'

for f in ${files}; do # ここのfiles変数はダブルコーテーションで囲まない
  cp -p "${f}" "${f}.$(date +%Y%m%d)"
done


# *展開を使用するバージョン
for f in file*; do
  cp -p "${f}" "${f}.$(date +%Y%m%d)"
done

# コマンド置換を使用するバージョン
for f in $(cd /home/testdir || exit; ls | grep -v tmpfile); do
  cp -p "${f}" "${f}.$(date +%Y%m%d)" 
done