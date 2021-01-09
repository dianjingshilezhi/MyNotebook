

## 一 基础语法

#### 1：查看端口信息

sudo netstat -ntlp

#### 2：强制删除端口id

sudo kill -9 （端口id）

![image-20200706193331437](C:\Users\赵煜\AppData\Roaming\Typora\typora-user-images\image-20200706193331437.png)

#### 3：压缩文件

sudo tar cvf TensorFlow.tar flie_name

tar -xvf TensorFlow.tar 释放一个包 

#### 4：iperf 打流

server：iperf -s -p12345 -i 1

client:	iperf -c server-ip  -p server-port -t 60 -b 300M

#### 5：配置删除网络代理

/etc/profile

/etc/environment

#### 6：&和&&,|和||

&  表示任务在后台执行，如要在后台运行redis-server,则有 redis-server &

&& 表示前一条命令执行成功时，才执行后一条命令 ，如 echo '1‘ && echo '2'   

| 表示管道，上一条命令的输出，作为下一条命令参数，如 echo 'yes' | wc -l

|| 表示上一条命令执行失败后，才执行下一条命令，如 cat nofile || echo "fail"

#### 7. 复制文件

cp dir1/a.txt  dir2

将dir1 下的a.txt 复制到dir2

cp dir1 -r  dir2

将dir1 整个文件复制到dir2,dir2包含dir1

cp -a dir1/.  dir2

将dir下的所有文件复制到dir2 ,不包含dir1

scp  将一台机器上的文件 复制到另一台

scp bridge-utils-1.6.tar.xz tx-onos.tar test@192.168.31.112:/home/test/

mv 移动/重命名

#### 8 :screen

```html
$> screen [-AmRvx -ls -wipe][-d <作业名称>][-h <行数>][-r <作业名称>][-s ][-S <作业名称>]
 
-A 　将所有的视窗都调整为目前终端机的大小。
-d   <作业名称> 　将指定的screen作业离线。
-h   <行数> 　指定视窗的缓冲区行数。
-m 　即使目前已在作业中的screen作业，仍强制建立新的screen作业。
-r   <作业名称> 　恢复离线的screen作业。
-R 　先试图恢复离线的作业。若找不到离线的作业，即建立新的screen作业。
-s 　指定建立新视窗时，所要执行的shell。
-S   <作业名称> 　指定screen作业的名称。
-v 　显示版本信息。
-x 　恢复之前离线的screen作业。
-ls或--list 　显示目前所有的screen作业。
-wipe 　检查目前所有的screen作业，并删除已经无法使用的screen作业。
    
    
    
screen -S yourname -> 新建一个叫yourname的session
screen -ls         -> 列出当前所有的session
screen -r yourname -> 回到yourname这个session
screen -d yourname -> 远程detach某个session
screen -d -r yourname -> 结束当前session并回到yourname这个session
```

#### 9: 流量重放tcpreplay

```
sudo apt-get install build-essential libpcap-dev

```

![img](https://upload-images.jianshu.io/upload_images/3406513-33317ba88538b245.png?imageMogr2/auto-orient/strip|imageView2/2/w/1156/format/webp)

```
   tcprewrite --enet-smac=host_src_mac,client_src_mac   \
              --enet-dmac=host_dst_mac, client_dst_mac \
              --endpoints=host_dst_ip:client_dst_ip    \
              --portmap=old_port1:new_port1,old_port2, new_port2 \
             -i input.pcap -c input.cach -o out.pcap


该命令的输入参数是input.pcap和input.cach文件, 结果将另存为out.pcap文件。
　　该命令将所有input.pcap包里的主机包(由input.cach文件指定哪些包是主机包, 哪些包是客户端包)的源mac地址, 目的mac地址，目的IP地址分别改为 :host_src_mac,host_dst_mac和host_dst_ip。
　　客户端包源mac地址, 目的mac地址，目的IP地址分别改为 :client_src_mac, client_dst_mac和client_dst_ip。
　　将端口号由old_port1改为 new_port1, 将端口号由old_port2改为new_port2。
```

#### 利用tcpprep进行预处理后发包

双网卡：

**第一步：**预处理生成Cache,命令为



```css
tcpprep -a client -i test.pcap -o test.cache
```

这条命令将PCAP文件分成客户端和服务端，默认为客户端。发送时packet将分别从客户端和服务端发出。

**第二步：**重写IP地址和MAC地址,命令为



```ruby
tcprewrite -e 192.85.1.2:192.85.2.2 --enet-dmac=00:15:17:2b:ca:14,00:15:17:2b:ca:15 --enet-smac=00:10:f3:19:79:86,00:10:f3:19:79:87 -c test.cache -i test.pcap -o 1.pcap 
```

这条命令将eth0设为服务端接口，eth1设为客户端接口，重写了IP和MAC,可通过wireshark等工具打开1.pcap，查看修改是否成功。

**第三步：**重放packet,命令为



```swift
tcpreplay -i eth0 -I eth1 -l 1000 -t -c /dev/shm/test.cache /dev/shm/1.pcap
```



单网卡：

tcpprep -a client -i test.pcap -o test.cache

 tcprewrite -e  10.0.0.1:10.0.0.2 --enet-dmac=DE:97:A8:DE:30:D2 --enet-smac=BE:50:EB:67:4A:46  --cachefile=test.cache --infile=test.pcap --outfile=output.pcap

sudo tcpreplay -v  -i h1-eth0 output.pcap

抓包tcpdump

```3
tcpdump -i h2-eth0 -w dump.pcap
```

#### 10  tcpdump 抓包

cpdump通常是供root用户使用的，如果机器上没有装，可以进行安装。
例如：centos上可以采用下面的命令进行安装。

```shell
yum install tcpdump
1
```

通常命令执行需要root权限，如果使用其它用户执行的话，需要使用sudo来提升执行权限：例如

```shell
[/aaa]$ tcpdump
tcpdump: ioctl(SIOCIFCREATE): Operation not permitted
[/aaa]$ sudo tcpdump tcp port 80
[sudo] password for aaa: 
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
...
1234567
```

##### 常用的命令

下面主要列了一些个人常用的命令，详细的tcpdump命令可以从参考文档中查看：

##### 写入文件：

-w filename 监听内容写入文件

##### 监听端口设置：

port 80 监听80端口
tcp port 80 tcp80端口
udp port 80 udp80端口
src port 80 来源端口80
dst port 80 发往端口80

监听IP设置：

host 192.168.0.1监听与主机192.168.0.1通信内容
src 192.168.0.1 监听来源自192.168.0.1内容
dst 192.168.0.1 监听发往192.168.0.1内容

监听指定网络接口：

-i eth0 监听eth0接口

注：执行tcpdump -D可以查看支持的接口有那些，例如如下

```shell
[/root]# tcpdump -D
1.eth0
2.nflog (Linux netfilter log (NFLOG) interface)
3.nfqueue (Linux netfilter queue (NFQUEUE) interface)
4.any (Pseudo-device that captures on all interfaces)
5.lo [Loopback]
123456
```

##### 命令行支持信息：

执行tcpdump --h可以查看tcpdump支持的命令字有那些，其中-i/-w上面提过，其它命令的使用可以从文章的参考文章中查看。

```shell
[root@/home/lcyu/myservice]# tcpdump --help
tcpdump version 4.9.2
libpcap version 1.5.3
OpenSSL 1.0.2k-fips  26 Jan 2017
Usage: tcpdump [-aAbdDefhHIJKlLnNOpqStuUvxX#] [ -B size ] [ -c count ]
                [ -C file_size ] [ -E algo:secret ] [ -F file ] [ -G seconds ]
                [ -i interface ] [ -j tstamptype ] [ -M secret ] [ --number ]
                [ -Q|-P in|out|inout ]
                [ -r file ] [ -s snaplen ] [ --time-stamp-precision precision ]
                [ --immediate-mode ] [ -T type ] [ --version ] [ -V file ]
                [ -w file ] [ -W filecount ] [ -y datalinktype ] [ -z postrotate-command ]
                [ -Z user ] [ expression ]
123456789101112
```

##### 常用样例：

1. 监听访问wikipad网站的443端口
   使用命令：tcpdump host www.wikipedia.org and port 443
   带写入文件时：tcpdump host www.wikipedia.org and port 443 -w wike.cap

```shell
[/aaa] $ sudo tcpdump host www.wikipedia.org and port 443
tcpdump: data link type PKTAP
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on pktap, link-type PKTAP (Apple DLT_PKTAP), capture size 262144 bytes
10:35:01.540597 IP bogon.51264 > text-lb.ulsfo.wikimedia.org.https: Flags [P.], seq 1152072059:1152072109, ack 4124909117, win 4096, options [nop,nop,TS val 203068101 ecr 1655401572], length 50
...
123456
```

1. 监听与192.168.0.1的udp协议通信情况
   命令：tcpdump host 192.168.0.1 and udp
   带写入文件：tcpdump host 192.168.0.1 and udp -w 1udp.cap

```shell
[/aaa]$ sudo tcpdump host 192.168.0.1 and udp
tcpdump: data link type PKTAP
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on pktap, link-type PKTAP (Apple DLT_PKTAP), capture size 262144 bytes
10:45:46.378370 IP bogon.1024 > broadcasthost.commplex-link: UDP, length 135
12345
```



#### 11: scp 传递文件

 scp -r  agentTest  test@192.168.31.110:/home/test

-r 代表传递文件夹



## 二 简单操作

### 1：获取curl返回的数据

```python
    cmd = "curl -X GET --header 'Accept: application/json' 'http://127.0.0.1:8181/onos/v1/zy/zy/bandwith' --user onos:rocks"
    args = shlex.split(cmd)
    process = subprocess.Popen(args, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
```

### 2：输出重定向

```python
shell中可能经常能看到：>/dev/null 2>&1

命令的结果可以通过%>的形式来定义输出

分解这个组合：“>/dev/null 2>&1” 为五部分。

1：> 代表重定向到哪里，例如：echo "123" > /home/123.txt
2：/dev/null 代表空设备文件
3：2> 表示stderr标准错误
4：& 表示 等同于 的意思，2>&1，表示2的输出重定向 等同于 1
5：1 表示stdout标准输出，系统默认值是1，所以">/dev/null"等同于 "1>/dev/null"
```

### 3:	进程处理

#### 3.1 :命令的末尾加上一个 `&` 号

```python
cp -R original/dir/ backup/dir/ &
这个命令的目的是将 original/dir/ 的内容递归地复制到 backup/dir/ 中,任务被放到后台执行之后，就可以立即继续在同一个终端上工作了，甚至关闭终端也不影响这个任务的正常执行。需要注意的是，如果要求这个任务输出内容到标准输出中（例如 echo 或 ls），即使使用了 &，也会等待这些输出任务在前台运行完毕。
```

#### 3.2: 显示进程

`jobs` 命令可以显示当前终端正在运行的进程，包括前台运行和后台运行的进程。它对每个正在执行中的进程任务分配了一个序号（这个序号不是进程 ID），可以使用这些序号来引用各个进程任务

```
$ jobs
[1]- Running cp -i -R original/dir/* backup/dir/ &
[2]+ Running find . -iname "*jpg" > backup/dir/images.txt &
```

#### 3.3：将后台进程放到前台

`fg` 命令可以将后台运行的进程任务放到前台运行，这样可以比较方便地进行交互。根据 `jobs` 命令提供的进程任务序号，再在前面加上 `%` 符号，就可以把相应的进程任务放到前台运行。

```
$ fg %1 # 将上面序号为 1 的 cp 任务放到前台运行
cp -i -R original/dir/* backup/dir/
```

#### 3.4: 将前台程序放到后台

`bg` 命令会将任务放置到后台执行，如果任务是暂停状态，也会被启动起来。

```
$ bg %1
[1]+ cp -i -R original/dir/* backup/dir/ &

```

如上所述，以上几个命令只能在同一个终端里才能使用。如果启动进程任务的终端被关闭了，或者切换到了另一个终端，以上几个命令就无法使用了。

如果要在另一个终端管理后台进程，就需要其它工具了。例如可以使用 [kill](https://bash.cyberciti.biz/guide/Sending_signal_to_Processes)[5] 命令从另一个终端终止某个进程：

```
kill -s STOP <PID>

```

### 4： 离线安装

以bridge-utils为例：

tar xvf bridge-utils-1.6.tar.xz

cd bridge-utils-1.6/

autoconf 

./configure 

make

 sudo make install

()

### 5: 更改权限

加入-R 参数，就可以将读写权限传递给子文件夹
例如chmod -R 777 /public_html



### 6：换源

修改配置文件/etc/apt/sources.list

内容替换为

阿里镜像源

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
apt-get update
```

#### 7:查找文件位置

**find / -name file_name**

### 8 screen

```html
---------在虚拟控制台之外可以用的命令----------
$> screen [-AmRvx -ls -wipe][-d <作业名称>][-h <行数>][-r <作业名称>][-s ][-S <作业名称>]
 
-A 　将所有的视窗都调整为目前终端机的大小。
-d   <作业名称> 　将指定的screen作业离线。
-h   <行数> 　指定视窗的缓冲区行数。
-m 　即使目前已在作业中的screen作业，仍强制建立新的screen作业。
-r   <作业名称> 　恢复离线的screen作业。
-R 　先试图恢复离线的作业。若找不到离线的作业，即建立新的screen作业。
-s 　指定建立新视窗时，所要执行的shell。
-S   <作业名称> 　指定screen作业的名称。
-v 　显示版本信息。
-x 　恢复之前离线的screen作业。
-ls或--list 　显示目前所有的screen作业。
-wipe 　检查目前所有的screen作业，并删除已经无法使用的screen作业。

--------在虚拟控制台内可以用的快捷键-----------
C-a ? -> 显示所有键绑定信息
C-a c -> 创建一个新的运行shell的窗口并切换到该窗口
C-a n -> Next，切换到下一个 window 
C-a p -> Previous，切换到前一个 window 
C-a 0..9 -> 切换到第 0..9 个 window
Ctrl+a [Space] -> 由视窗0循序切换到视窗9
C-a C-a -> 在两个最近使用的 window 间切换 
C-a x -> 锁住当前的 window，需用用户密码解锁
C-a d -> detach，暂时离开当前session，将目前的 screen session (可能含有多个 windows) 丢到后台执行，并会回到还没进 screen 时的状态，此时在 screen session 里，每个 window 内运行的 process (无论是前台/后台)都在继续执行，即使 logout 也不影响。 
C-a z -> 把当前session放到后台执行，用 shell 的 fg 命令则可回去。
C-a w -> 显示所有窗口列表
C-a t -> time，显示当前时间，和系统的 load 
C-a k -> kill window，强行关闭当前的 window
C-a [ -> 进入 copy mode，在 copy mode 下可以回滚、搜索、复制就像用使用 vi 一样
    C-b Backward，PageUp 
    C-f Forward，PageDown 
    H(大写) High，将光标移至左上角 
    L Low，将光标移至左下角 
    0 移到行首 
    $ 行末 
    w forward one word，以字为单位往前移 
    b backward one word，以字为单位往后移 
    Space 第一次按为标记区起点，第二次按为终点 
    Esc 结束 copy mode 
C-a ] -> paste，把刚刚在 copy mode 选定的内容贴上
    
    
    
    
    
    开始使用Screen

简单来说，Screen是一个可以在多个进程之间多路复用一个物理终端的窗口管理器。Screen中有会话的概念，用户可以在一个screen会话中创建多个screen窗口，在每一个screen窗口中就像操作一个真实的telnet/SSH连接窗口那样。在screen中创建一个新的窗口有这样几种方式：

1．直接在命令行键入screen命令

[root@tivf06 ~]# screen


Screen将创建一个执行shell的全屏窗口。你可以执行任意shell程序，就像在ssh窗口中那样。在该窗口中键入exit退出该窗口，如果这是该screen会话的唯一窗口，该screen会话退出，否则screen自动切换到前一个窗口。

2．Screen命令后跟你要执行的程序。

[root@tivf06 ~]# screen vi test.c


Screen创建一个执行vi test.c的单窗口会话，退出vi将退出该窗口/会话。

3．以上两种方式都创建新的screen会话。我们还可以在一个已有screen会话中创建新的窗口。在当前screen窗口中键入C-a c，即Ctrl键+a键，之后再按下c键，screen 在该会话内生成一个新的窗口并切换到该窗口。

screen还有更高级的功能。你可以不中断screen窗口中程序的运行而暂时断开（detach）screen会话，并在随后时间重新连接（attach）该会话，重新控制各窗口中运行的程序。例如，我们打开一个screen窗口编辑/tmp/abc文件：

[root@tivf06 ~]# screen vi /tmp/abc


之后我们想暂时退出做点别的事情，比如出去散散步，那么在screen窗口键入C-a d，Screen会给出detached提示：


暂时中断会话



半个小时之后回来了，找到该screen会话：

[root@tivf06 ~]# screen -ls
There is a screen on:
        16582.pts-1.tivf06      (Detached)
1 Socket in /tmp/screens/S-root.


重新连接会话：

[root@tivf06 ~]# screen -r 16582
```

### 9 TC

```
sudo tc qdisc add dev eth0 root netem loss 10%
```

**模拟延迟**

下面命令，从 eth0 网口出去的包将延迟 40ms：

```
sudo tc qdisc add dev eth0 root netem delay 40ms
```

**特定场景下的丢包和延迟
**

注意，上面我们介绍的命令，是针对整个 eth0 网口起作用的，也就是说，只要是从 eth0 出去的所有的包，都会产生随机丢包或者延迟。但有时候，我们只想让丢包和延迟作用于某个目的地址，那要怎么做呢？

```
sudo tc qdisc add dev eth0 root handle 1: prio
sudo tc qdisc add dev eth0 parent 1:3 handle 30: netem loss 13% delay 40ms
sudo tc filter add dev eth0 protocol ip parent 1:0 u32 match ip dst 199.91.72.192 match ip dport 36000 0xffff flowid 1:3
```

上面的命令，我们告诉 tc，对发往 199.91.72.192:36000 的网络包产生 13% 的丢包和 40ms 的延迟，而发往其它目的地址的网络包将不受影响。

**删除规则**

好了，模拟完丢包和延迟之后，要记得删除掉规则：

如果要删除某一条规则，按照创建的时候，怎么创建的怎么删除。

```
sudo tc qdisc del dev eth0 root
```