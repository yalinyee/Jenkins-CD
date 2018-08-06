# Jenkins用Pipeline搭建CD一建发布

## 参考资料

[参考１](https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/)

[参考２](https://liatrio.com/building-docker-jenkins-pipelines/)

[参考３](https://code-maze.com/ci-jenkins-docker/)

[参考４](https://jenkins.io/doc/book/pipeline/docker/#using-multiple-containers)



## Jenkins搭建

#### ２.1环境说明

采用docker安装方式，这种方式Jenkins相当于一个容器，在Jenkins容器内部需要用启动docker容器来进行mvn打包、重启微服务等。微服务部署在容器里面，docker-compose来统一管理微服务容器，所以需要确保Jenkin容器内部可以执行docker、docker-compose命令。

*备注：*

*本例采用Docker out Docker(DouD)方式来使容器内的容器和外部容器通讯,将内部容器的/var/run/docker.sock 挂在到外部容器的 /var/run/docker.sock上面，docker.sock为容器进程文件，这样内部容器就可以和外部容器通讯。

*在Jenkins容器内部安装docker-compose，以便pipeline可以执行docker-compose命令。*

#### ２.2 Jenkins镜像制作

- 编辑Dockerfile

　Jenkins镜像中安装了docker-compose。

**详见jenkins/Dockerfile**

- 编辑docker-compose.yml

**详见jenkins/docker-compose.yml**

### ２.3 启动Jenkins容器

```
[root@reg jenkins]# docker-compose up -d
```

### ２.4 网页访问并登录jenkins

```
##网页访问
http://localhost:8080/
##获取jenkins登录密码
docker exec jenkins_jenkins_1　cat /var/jenkins_home/secrets/initialAdminPassword
##登录用户为admin
```

至此jenkins环境搭建完毕

## Jenkins基础环境配置

#### ３.1 插件安装

Jenkins系统配置的插件管理中，需要安装[Docker Pipeline]、[SSH Agent Plugin]等相关插件。

#### ３.2 私有仓库用户名密码配置

用于push镜像到私有镜像仓库。

<u>在凭据中添加一条凭据</u>

<u>类型选择：【Username with password】</u>

<u>Username：镜像私有仓库用户名</u>

Password：镜像私有仓库用户密码	

<u>ID:　Jenkinsfile中根据此ID获取凭据配置信息，本例中为dockerHarbor</u>

#### ３.３ 本机私钥凭据配置

用于从git库中下载代码、远程ssh发布到目标主机。

<u>在凭据中添加一条凭据</u>

<u>pipeline语法参考官网类型选择：【SSH Username with private key】</u>

<u>Username：本机(linux)的用户，本例是root</u>

<u>Private Key：此用户下的私钥(cat ~/.ssh/id_rsa)</u>

<u>ID:　Jenkinsfile中根据此ID获取凭据配置信息，本例中为jenkins-root

#### ３.4 git代码库ssh　key配置

将cat ~/.ssh/id_rsa.pub 中的公钥复制到git代码库的ssh key配置中

#### ３.5 将本机公钥添加到要发布的目标主机受信的authorized_keys中

本例是将本机的/.ssh/id_rsa.pub(公钥)复制到目标主机172.16.0.34的authorized_keys中。

```
# ssh -p 22 root@172.16.0.111 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```

## Jenkins使用pipeline搭建CD

#### 4.1新建pipeline项目

【新建任务】-->选择【pipeline】(流水线)

#### 4.2 配置pipeline

选择刚刚新建的pipeline项目，配置pipeline：

1. 选择Pipeline script from SCM
2. 选择SCM
3. 配置脚本路径(Jenkinsfile的路径)

#### 4.3 编写Jenkinsfile

**详见jenkins/scripts/Jenkinsfile**

#### 4.4 一建发布

- 可以自己写个scp将docker-compose.yml上传到目标主机
- 进入刚刚创建的pipeline，点击【立即构建】，就开始一建发布了

[pipeline语法参考官网](https://jenkins.io/doc/book/pipeline/syntax/)
