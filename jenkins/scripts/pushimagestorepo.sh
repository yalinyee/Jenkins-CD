#!/usr/bin/env bash

echo 'login repo reg.evercenter.cn'

docker login -u JamesYe -p Yyl123456 reg.evercenter.cn

echo 'push images start'
# `docker images | grep 'reg.evercenter.cn' |awk '{print ("docker push "$1":"$2)}'`


docker push reg.evercenter.cn/seacloud/communication-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/auth-server:v0.2
#sudo docker push reg.evercenter.cn/seacloud/gateway-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/discovery-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/config-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/statistics-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/user-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/library-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/database-service:v0.2
#sudo docker push reg.evercenter.cn/seacloud/device-service:v0.2


echo 'push images end'

