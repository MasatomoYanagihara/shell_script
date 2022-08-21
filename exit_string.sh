#!/bin/bash

# exitでstringはreturnできない。
# exitとは別にechoでエラー出力を行う。
# 終了ステータスで使えるのは「0-255」の数。
echo "Bad filename" >&2
exit 1