1. 打开虚拟机（202.117.15.111）

```
cd ~/etps/openstack/images

sudo virt-install \
--virt-type kvm \
--name vm \
--ram 2048 \
--vcpus 1 \
--boot hd \
--disk ubuntu18-ovx-sdnip-onos-0914.img,bus=virtio,size=20,format=qcow2 \  # 要修改的vm
--network network=default \
--graphics vnc,listen=0.0.0.0 \
--os-type=linux --os-variant=ubuntu18.04
```

2. 更新虚拟机

```

docker pull neptune15/host_iperf:v4
docker pull neptune15/ovx:v4.3

cd ~/etps/dataplane/ovx/scripts/
rm embedder.py
vi embedder.py
cd ~/etps/dataplane/ovx/scripts/src/algorithms/
rm my_final_algorithm.py
vi my_final_algorithm.py

cd ~/etps/dataplane/ovx/

docker build -t neptune15/ovx:v4 .

```



3. 关机

```
sudo shutdown -h now
sudo virsh undefine vm
```

4. 上传到openstack服务器（:）

```
sftp 192.168.31.20
put xxx.img
```

5. 加载到openstack

```
ssh test@192.168.31.20

. /etc/kolla/admin-openrc.sh

openstack image list
openstack server list  # 删除正在使用旧镜像的server

# 删除旧镜像
openstack image delete ubuntu18

# 上传新镜像
openstack image create \
--disk-format=qcow2 \
--container-format=bare \
--file=xxx.img \  # 上传的镜像
ubuntu18
openstack image create \
--disk-format=qcow2 \
--container-format=bare \
--file=ubuntu1811.img \  
ubuntu18.1.1
```

