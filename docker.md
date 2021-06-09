# 测试ovx

## docker

docker ps -a

 sudo docker stop server

sudo docker rm server

```
1. ssh 到demo-ovx
# ssh test@192.168.31.xxx

2. 进入主机容器
docker exec -it  mn.hxx /bin/bash
ping 10.0.0.xx
exit 退出容器

对于哪个主机ping哪个主机
可以通过查看虚拟网络上面挂着的主机看到
cd ~/etps/dataplane/ovx/utils
python ovxctl.py -n getVirtualHosts xx   #tenant_id

查看交换机的映射
python ovxctl.py -n getVirtualSwitchMapping xx

ovs-vsctl show
ovs-ofctl show
```

列出镜像

docker images 

加载镜像

load

![image-20200923182617202](C:\Users\赵煜\AppData\Roaming\Typora\typora-user-images\image-20200923182617202.png)

给镜像打tag

docker tag id 名字:标签

![image-20200923182719824](C:\Users\赵煜\AppData\Roaming\Typora\typora-user-images\image-20200923182719824.png)

![image-20200923182757880](C:\Users\赵煜\AppData\Roaming\Typora\typora-user-images\image-20200923182757880.png)

删除镜像

docker rmi 镜像id

#下载最新的tomcat版本
docker pull tomcat 或 docker image pull tomcat

docker images  #查看本地全部镜像

#以后台交互式窗口的方式运行tomcat镜像，并将容器命名为tomcat8080
#其中-itd为-i -t -d 三个命令的所写#docker run ：创建一个新的容器并运行一个命令
docker run -itd --name tomcat8080 tomcat 

#查看当前运行的容器信息
docker ps #删除容器的命令docker rm -f $containerName  #强制终止并删除容器

## Docker容器向宿主机传送文件

格式:

```python
docker cp container_id:<docker容器内的路径> <本地保存文件的路径>
1
```

比如:

```python
docker cp 10704c9eb7bb:/root/test.text /home/vagrant/test.txt
1
```

## 宿主机向Docker容器传送文件

格式:

```python
docker cp 本地文件的路径 container_id:<docker容器内的路径>
1
```

比如:

```python
docker cp  /home/vagrant/test.txt 10704c9eb7bb:/root/test.text
```

```
apk 换源

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
```



### 保存容器为新镜像

  命令：docker commit -m “” -a “” [CONTAINER ID] [给新的镜像命名]

```shell
docker commit -a "runoob.com" -m "my apache" a404c6c174a2  bb:v1
1
```

### 保存镜像为文件

  命令：docker save -o 要保存的文件名 要保存的镜像

例子：

```shell
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# ls
aaa.cap  install.sh  mobile-1.0.0-SNAPSHOT.jar  sa_recovery.log
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
bb                  v1.0                3b8d26737bcb        10 minutes ago      202MB
centos              latest              9f38484d220f        3 weeks ago         202MB
java                latest              d23bdf5b1b1b        2 years ago         643MB
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker save -o cc.tar bb:v1.0
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# ls
aaa.cap  cc.tar  install.sh  mobile-1.0.0-SNAPSHOT.jar  sa_recovery.log
12345678910
```

### 导入文件生成镜像

  命令：docker load --input 文件 或者 docker load < 文件名

```shell
docker load --input 文件  
或者  
docker load < 文件名
123
```

例子：

```shell
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker rm -f aa
aa
[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker rmi centos:latest bb:v1.0
Untagged: bb:v1.0
Deleted: sha256:3b8d26737bcb99aa12ef55c6e9620720b0ad85ecdee9cd52fbb5d5e1a2da2591
Untagged: centos:latest
Untagged: centos@sha256:8d487d68857f5bc9595793279b33d082b03713341ddec91054382641d14db861
Deleted: sha256:9f38484d220fa527b1fb19747638497179500a1bed8bf0498eb788229229e6e1
Deleted: sha256:d69483a6face4499acb974449d1303591fcbb5cdce5420f36f8a6607bda11854

[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
java                latest              d23bdf5b1b1b        2 years ago         643MB

[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker load < cc.tar 
d69483a6face: Loading layer [==================================================>]  209.5MB/209.5MB
Loaded image: bb:v1.0


[root@iZbp16cdvzk4rhl0vn1gedZ ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
bb                  v1.0                3b8d26737bcb        15 minutes ago      202MB
java                latest              d23bdf5b1b1b        2 years ago         643MB
```

上传镜像到云平台

 openstack image create --disk-format=qcow2 --container-format=bare --file=oxp-1025.img oxp-1025

从云平台下载镜像

![image-20201025130824028](C:\Users\赵煜\AppData\Roaming\Typora\typora-user-images\image-20201025130824028.png)

### build

docker pull neptune15/host_iot:v1

 sudo docker build -t neptune15/host_iot:v1 .doc