#!/usr/bin/env bash

# this script used in docker-compose
echo "start webase-front now..."
cp -r /dist/sdk/* /dist/conf/
echo "finish copy sdk files to front's conf dir"
#使用nsloopup命令获取主机 fisco-bcos 的ip 地址
FISCO_BCOS_IP=`nslookup ${SDK_IP} | grep Address | tail -n 1 | awk '{print $2}'`
# 截取 FISCO_BCOS_IP 中#号之前的字符串
FISCO_BCOS_IP=${FISCO_BCOS_IP%#*}
echo "FISCO_BCOS_IP is ${FISCO_BCOS_IP}"
echo "SDK_IP is ${SDK_IP}" "KEY_SERVER is ${KEY_SERVER}"
# 使用sed 将包含keyServer的行替换为keyServer的值
sed -i "s/keyServer: .*/keyServer: ${KEY_SERVER}/g" /dist/conf/application.yml
# 使用sed 命令将 空格空格ip: 行替换为 空格空格ip: ${FISCO_BCOS_IP}
sed -i "s/  ip:.*/  ip: ${FISCO_BCOS_IP}/g" /dist/conf/application.yml
# 输出application.yml文件
cat /dist/conf/application.yml

# 将环境变量 SDK_IP 设置为 FISCO_BCOS_IP
export SDK_IP=${FISCO_BCOS_IP}

java ${JAVA_OPTS} -Djdk.tls.namedGroups="secp256k1", -Duser.timezone="Asia/Shanghai" -Djava.security.egd=file:/dev/./urandom, -Djava.library.path=/dist/conf -cp ${CLASSPATH}  ${APP_MAIN}