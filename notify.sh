#!/bin/bash


data=$(cat trigger.txt|awk '{print $2}')

# 定义 JSON 格式的文本

json_data=$(cat <<EOF
{
    "at": {
        "atUserIds":[
            "382113"
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

url="https://oapi.dingtalk.com/robot/send?access_token=c232dc00b74a3a0ddc09c77e688eca4c595032cc433450cc2e516cfa9f6313f5"

# 定义 URL
MM_NOTIFY_URL=${url}

# 创建一个临时文件来存储 JSON 数据
tmpfile=$(mktemp /tmp/json.XXXXXX)

# 将 JSON 数据写入临时文件
echo "$json_data" > "$tmpfile"

# 使用 curl 发送 POST 请求
curl -d "@$tmpfile" -H "Content-Type: application/json" "$MM_NOTIFY_URL"

# 删除临时文件
rm "$tmpfile"

