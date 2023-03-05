#!/bin/bash

# 現在時刻から1時間前までのタイムスタンプを取得
one_hour_ago=$(date -d '-1 hour' '+%d/%b/%Y:%H:%M:%S')

# ログファイルのパス
access_log="./access.log"

# ステータスコードのカウントを初期化
declare -A status_code_count=(
  ["100"]=0
  ["200"]=0
  ["300"]=0
  ["400"]=0
  ["500"]=0
)

# アクセスログを1行ずつ読み込んでステータスコードをカウントする
while read -r line;do
  field2=$(echo "${line}" | awk '{print $2}')

  if [[ "${field2}" =~ \"$ ]]; then
    # IPアドレスが２つの場合
    log_time=$(echo "${line}" | awk '{print $5}' | sed -e 's@\[@@')
    status_code=$(echo "${line}" | awk '{print $10}')
  else
    # IPアドレスが１つの場合
    log_time=$(echo "${line}" | awk '{print $4}' | sed -e 's@\[@@')
    status_code=$(echo "${line}" | awk '{print $9}')
  fi

  # ログの日時が指定範囲外の場合はスキップする
  if [[ "${log_time}" < "${one_hour_ago}" ]]; then
    continue
  fi

  case "${status_code}" in
    1??) ((status_code_count["100"]++)) ;;
    2??) ((status_code_count["200"]++)) ;;
    3??) ((status_code_count["300"]++)) ;;
    4??) ((status_code_count["400"]++)) ;;
    5??) ((status_code_count["500"]++)) ;;
    *) ;;
  esac

done < "${access_log}"

# ステータスコードのカウントを表示する
printf "1xx(%3s) 2xx(%3s) 3xx(%3s) 4xx(%3s) 5xx(%3s)\n" \
       "${status_code_count["100"]}" \
       "${status_code_count["200"]}" \
       "${status_code_count["300"]}" \
       "${status_code_count["400"]}" \
       "${status_code_count["500"]}"