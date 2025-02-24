#!/bin/bash


data=$(cat trigger.txt|awk '{print $2}')

# 定义 JSON 格式的文本

json_data=$(cat <<EOF
{
    "at": {
        "atUserIds":[
            "014728255240768602"
        ],
        "isAtAll": false
    },
    "text": {
        "content":"镜像同步成功\n${data}"
    },
    "msgtype":"text"
}
EOF
)

# 定义 URL
MM_NOTIFY_URL=$1

# 创建一个临时文件来存储 JSON 数据
tmpfile=$(mktemp /tmp/json.XXXXXX)

# 将 JSON 数据写入临时文件
echo "$json_data" > "$tmpfile"

# 使用 curl 发送 POST 请求
curl -d "@$tmpfile" -H "Content-Type: application/json" "$MM_NOTIFY_URL"

# 删除临时文件
rm "$tmpfile"

