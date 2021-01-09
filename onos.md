## 启动onos

cd onos/

op

ok

未编译版本：

cd onos/bin

./onos-server clean >/dev/null $

启动onos，丢掉输出，放在后台

#### 进入onosUI界面

http://localhost:8181/onos/ui/

预设的用户名称：onos
预设的用户密码：rocks

#### 进入cli

onos localhost

app activate zy

app deactivate zy

在文件目录下安装应用

onos-app localhost reinstall onos-apps-zy-oar.oar

未编译版本：

cd onos/bin 

./onos

## mininet

创建topo

sudo mn --topo=tree,3,2 --controller remote

使用脚本

```python
# sudo mn --custom 2s_8h.py --topo mytopo  --controller=remote,ip=211.69.197.92,port=6653 --mac
from mininet.node import DockerOVS, Docker, RemoteController
from mininet.log import setLogLevel
from mininet.examples.clustercli import ClusterCLI as CLI
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.link import TCLink
 
class MyTopo( Topo ):
 
    def __init__( self ):
 
        # initilaize topology   
        Topo.__init__( self )
 
        # add hosts and switches
        h1 = self.addHost( 'h1' )
        h2 = self.addHost( 'h2' )
        h3 = self.addHost( 'h3' )
        s1 = self.addSwitch( 's1' )
        s2 = self.addSwitch( 's2' )
 
        # add links
        self.addLink(h1,s1,1,1,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(h2,s1,1,3,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(h3,s2,1,1,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(s1,s2,2,2,bw=0.5,delay='10ms',loss=0.2)
 
topos = { 'mytopo': ( lambda: MyTopo() ) }
```

​     h1--------      s1------------s2

​                           |                 |

​                           h2                 h3



test2.py

```python
from mininet.node import DockerOVS, Docker, RemoteController
from mininet.log import setLogLevel
from mininet.examples.clustercli import ClusterCLI as CLI
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.link import TCLink



class MyTopo( Topo ):
 
    def __init__( self ):
 
        # initilaize topology   
        Topo.__init__( self )
 
        # add hosts and switches
        h1 = self.addHost( 'h1' )
        h2 = self.addHost( 'h2' )
        h3 = self.addHost( 'h3' )
        s1 = self.addSwitch( 's1' )
        s2 = self.addSwitch( 's2' )
 
        # add links
        self.addLink(h1,s1,1,1,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(h2,s1,1,3,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(h3,s2,1,1,bw=0.5,delay='10ms',loss=0.2)
        self.addLink(s1,s2,2,2,bw=0.5,delay='10ms',loss=0.2)

def start_topo():
   
    topo = Mytopo()
    link = TCLink
    net = Mininet(topo=topo, link=link,
                  controller=RemoteController(name='c', ip='127.0.0.1', port=6633))
    net.start()

    net.pingAll()

    # for test
    CLI(net)
    net.stop()
    # return topo.structure


if __name__ == '__main__':
    start_topo()

    
    
cd mininet/mininet/examples
sudo python test2.py
```

