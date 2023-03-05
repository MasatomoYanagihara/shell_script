#!/bin/bash

access_log="./access.log"

# ステータスコードのカウントを初期化
declare -A status_code_count=(
  ["100"]=0
  ["200"]=0
  ["300"]=0
  ["400"]=0
  ["500"]=0
)

while read -r line;do
  field2=$(echo "${line}" | awk '{print $2}')

  if [[ "${field2}" =~ \"$ ]]; then
    status_code=$(echo "${line}" | awk '{print $10}')
  else
    status_code=$(echo "${line}" | awk '{print $9}')
  fi

  case ${status_code} in
    1??) ((status_code_count["100"]++)) ;;
    2??) ((status_code_count["200"]++)) ;;
    3??) ((status_code_count["300"]++)) ;;
    4??) ((status_code_count["400"]++)) ;;
    5??) ((status_code_count["500"]++)) ;;
    *) ;;
  esac
done < "${access_log}"

printf "1xx(%3s) 2xx(%3s) 3xx(%3s) 4xx(%3s) 5xx(%3s)\n" \
       "${status_code_count["100"]}" \
       "${status_code_count["200"]}" \
       "${status_code_count["300"]}" \
       "${status_code_count["400"]}" \
       "${status_code_count["500"]}"
