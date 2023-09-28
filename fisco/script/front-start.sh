#!/usr/bin/env bash

# this script used in docker-compose
echo "start webase-front now..."
cp -r /dist/sdk/* /dist/conf/
echo "finish copy sdk files to front's conf dir"
#使用nsloopup命令获取主机 fisco-bcos 的ip 地址
FISCO_BCOS_IP=`nslookup ${SDK_IP} | grep Address | tail -n 1 | awk '{print $2}'`
# 截取 FISCO_BCOS_IP 中#号之前的字符串
FISCO_BCOS_IP=${FISCO_BCOS_IP%#*}

#使用nsloopup命令获取主机 webase-sign 的ip 地址
WEBASE_SIGN_IP=`nslookup webase-sign | grep Address | tail -n 1 | awk '{print $2}'`
# 截取 WEBASE_SIGN_IP 中#号之前的字符串
WEBASE_SIGN_IP=${WEBASE_SIGN_IP%#*}

# 将环境变量 SDK_IP 设置为 FISCO_BCOS_IP
export SDK_IP=${FISCO_BCOS_IP}

export KEY_SERVER=${WEBASE_SIGN_IP}:5004
echo "FISCO_BCOS_IP is ${FISCO_BCOS_IP}"
echo "SDK_IP is ${SDK_IP}" "KEY_SERVER is ${KEY_SERVER}"

java ${JAVA_OPTS} -Djdk.tls.namedGroups="secp256k1", -Duser.timezone="Asia/Shanghai" -Djava.security.egd=file:/dev/./urandom, -Djava.library.path=/dist/conf -cp ${CLASSPATH}  ${APP_MAIN}