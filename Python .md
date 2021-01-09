

# Python 命名规范

1.项目名称
首字母大写+大写式驼峰，
ProjectName

2.模块名和包名
全部小写+下划线驼峰
module_name  package_name

3.类名称，异常
首字母大写+大写式驼峰，
class ClassName:  ，ExceptionName

4.全局变量、常量
全部使用大写字母+下划线驼峰
GLOBAL_VAR_NAME，CONSTANT_NAME

5.方法名，函数名，其余变量，参数，实例
全部小写+下划线驼峰
method_name，function_name，instance_var_name, function_parameter_name, local_var_name

6.处理计数器外，不使用单字母命名



## json

JSON(JavaScript Object Notation) 是一种轻量级的数据交换格式，它使得人们很容易的进行阅读和编写。同时也方便了机器进行解析和生成。适用于进行数据交互的场景，比如网站前台与后台之间的数据交互。
Python中自带了json模块，直接`import json`即可使用

官方文档：[http://docs.python.org/librar...](http://docs.python.org/library/json.html)
Json在线解析网站：http://www.json.cn/#

json简单说就是`javascript`中的`对象`和`数组`，所以这两种结构就是对象和数组两种结构，通过这两种结构可以表示各种复杂的结构。

~~~html
对象：对象在js中表示为{ }括起来的内容，数据结构为 { key：value, key：value, ... }的键值对的结构，在面向对象的语言中，key为对象的属性，value为对应的属性值，所以很容易理解，取值方法为 对象.key 获取属性值，这个属性值的类型可以是数字、字符串、数组、对象这几种。
数组：数组在js中是中括号[ ]括起来的内容，数据结构为 ["Python", "javascript", "C++", ...]，取值方式和所有语言中一样，使用索引获取，字段值的类型可以是 数字、字符串、数组、对象几种。
~~~

```python
import json

# JSON文本字符串
str_list = '["a","b","c","d"]'
str_dict = '{"name":"小白","age":1000}'

# json.loads将文本字符串转化为JSON对象，在Python里就是Python对象了
data_list = json.loads(str_list)
data_dict = json.loads(str_dict)

print(type(data_list))
print(type(data_dict))
print(data_list)
print(data_dict)

```



**json.loads()**
`json.loads()`方法将JSON文本字符串转换为Python对象.JSON文本字符串中，数据应该用`双引号`括起来，不然会报错误，比如上面str_list和str_dict中的值都应该用双引号，数字就不用

**json.dumps**
`json.dumps()`方法实现python类型转化为json字符串，返回一个str对象把一个Python对象编码转换成Json字符串.

说明：dumps方法可以将Python数据类型转化为JSON文本字符串，但是可以看到当有中文的时候，转换后中文字符都变成Unicode字符，要输出中文需要设置dumps方法的参数`ensure_ascii=True`设置为`ensure_ascii=False`。如下：

```python
print(json.dumps(data_dict,ensure_ascii=False))
# 运行结果：{"name": "小黑", "age": 1000}
```

此外，如果需要将数据保存为文本的时候，还需要指定文件的编码格式为`utf-8`，比如将上面的`data_dict`数据(里面有中文字符)保存为data.json文件，indent 表示格式缩进,代码如下：

```python
with open('data.json','w',encoding='utf-8') as f:
    f.write(json.dumps(data_dict,ensure_ascii=False,indent=2))
```

## shell中调用python脚本

```python
def sum(a,b):
    c=a+b
    print(c)
if __name__ == '__main__':
    sum(int(sys.argv[1]),int(sys.argv[2]))
```

shell -- python test.py 1 2
		  -- 3

## shell 中调用python脚本中的函数

python -c 'import test;test.sum(1,2)'

## shell中复制粘贴

鼠标左键选中，右键复制，右键粘

## Python脚本使用系统命令调用Python文件

```python
import os
os.system('python F:\...\Test.py 你要传入的参数')
```



脚本获取参数

```python
if __name__ == '__main__':
    if len(sys.argv) > 1:
        structure = start_containers(sys.argv[1], sys.argv[2])
        print(structure)

```

## python import导入上一级目录模块

```python
调用上级目录下的文件
-- src
    |-- mod1.py
    |-- lib
    |    |-- mod2.py
    |-- sub
    |    |-- test2.py
这里想要实现test2.py调用mod1.py和mod2.py 
import sys
sys.path.append("..")
import mod1
import mod2.mod
```

## 判断字典，数组，列表是否为空

在python里，{},[],()，等都等价于False！

```python
if dict:
    print 'not Empty'
```

## 判断是否有键值

```python
#判断字典中某个键是否存在
arr = {"int":"整数","float":"浮点","str":"字符串","list":"列表","tuple":"元组","dict":"字典","set":"集合"}
#使用 in 方法
if "int" in arr:
    print("存在")
if "float" in arr.keys():
    print("存在")
#判断键不存在
if "floats" not in arr:
    print("不存在")
if "floats" not in arr:
    print("不存在")
```





## 获取当前时间并格式化

```python
import time
print time.time()
输出的结果是：
1357723206.31

time.localtime(time.time())
用time.localtime()方法，作用是格式化时间戳为本地的时间。
输出的结果是：
time.struct_time(tm_year=2010, tm_mon=7, tm_mday=19, tm_hour=22, tm_min=33, tm_sec=39, tm_wday=0, tm_yday=200, tm_isdst=0)

time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
2013-01-09



start = datetime.now()
start_time = start.strftime("' %H:%M:%S'")
end = datetime.now()
#时间差
delta_seconds = (end - start).seconds
#加上10秒之后的时间
pre_time = (true_time +timedelta(seconds=10)).strftime('%H:%M:%S')

```

## OS 模块

### 执行shell命令

```python
os.system('python3 node_evaluate.py {}'.format(server_ip))
if len(sys.argv) > 1:
        node_evaluate(sys.argv[1])
```

### path

```python
os.path.basename(path)
返回文件名
os.path.dirname(path)
返回文件路径
os.path.getctime(“/root/1.txt”)
返回1.txt的ctime(创建时间)时间戳
os.path.exists(os.getcwd())
判断文件是否存在
os.path.isfile(os.getcwd())
判断是否是文件名，1是0否
os.path.isdir(‘c:\Python\temp’)
判断是否是目录，1是0否

```

### 创建，删除一个文件

```python 
with open('mw_server4/api/flag.py','w') as f:
    f.close()
os.remove('mw_server4/api/flag.py')
print(os.path.exists('mw_server4/api/flag.py'))
```

## 多线程

### Threading模块

```python
import threading
import time

def run(n):
    print("task", n)
    time.sleep(1)
    print('2s')

if __name__ == '__main__':
    t1 = threading.Thread(target=run, args=("t1",))
    t2 = threading.Thread(target=run, args=("t2",))
    t1.start()
    t2.start()

```

### 守护线程

使用setDaemon(True)把所有的子线程都变成了主线程的守护线程，因此当主进程结束后，子线程也会随之结束。所以当主线程结束后，整个程序就退出了

```pyhton
    t = threading.Thread(target=run, args=("t1",))
    t.setDaemon(True)   #把子进程设置为守护线程，必须在start()之前设置
    t.start()
    print("end")
```

### 主线程等待子线程结束

为了让守护线程执行结束之后，主线程再结束，我们可以使用join方法，让主线程等待子线程执行

```python 
    t = threading.Thread(target=run, args=("t1",))
    t.setDaemon(True)   #把子进程设置为守护线程，必须在start()之前设置
    t.start()
    t.join() # 设置主线程等待子线程结束
    print("end")
```

### for循环添加多个线程

```python
threads = [];#存放线程的数组，相当于线程池
for i in range(0,5):
    thread = myThread(i);#指定线程i的执行函数为myThread
    threads.append(thread);#先讲这个线程放到线程threads
for t in threads:#让线程池中的所有数组开始
    t.start(); 
for t in threads:
    t.join();#等待所有线程运行完毕才执行一下的代码
```

这里不能写成如下的代码段：

```python
for t in threads:#让线程池中的所有数组开始
    t.start();
    t.join();#等待所有线程运行完毕才执行一下的代码
```

这样的话，主程序会等待线程0，跑完myThread中的所有代码，才去创建线程1,2,3.....的，这样达不到线程并发的目的，程序变成单线程执行了，这是批量创建线程需要注意的地方

### 线程锁

```python
如何实现线程锁?
1. 实例化一个锁对象;
lock = threading.Lock()
2. 操作变量之前进行加锁
lock.acquire()
3. 操作变量之后进行解锁
lock.release()
```

```python
import threading


#  银行存钱和取钱
def add(lock):
    global money  # 生命money为全局变量
    for i in range(1000000):
        # 2. 操作变量之前进行加锁
        lock.acquire()
        money += 1  # money;  money+1; money=money+1;
        # 3. 操作变量之后进行解锁
        lock.release()


def reduce(lock):
    global money
    for i in range(1000000):
        # 2. 操作变量之前进行加锁
        lock.acquire()
        money -= 1
        # 3. 操作变量之后进行解锁
        lock.release()


if __name__ == '__main__':
    money = 0
    # 1. 实例化一个锁对象;
    lock = threading.Lock()

    t1 = threading.Thread(target=add, args=(lock,))
    t2 = threading.Thread(target=reduce, args=(lock,))
    t1.start()
    t2.start()
    t1.join()
    t2.join()

    print("当前金额:", money)

```

## 执行shell 命令

**一、os.system(“command”)**

```
import os
print(os.system("touch a.txt"))
print(os.system("ls -a"))
```

第2行会返回一个0，表示执行成功了，然后在当前文件夹之下创建了一个新的a.txt文件

第3行也会返回一个0，也就是说这个命令执行的结果没有办法查看，即system函数不返回shell命令执行的结果。

**二、os.popen("command")方法** 

os.popen() 返回的是一个文件对象

```
import os
 
f=os.popen("ls -l")  # 返回的是一个文件对象
print(f.read())            # 通过文件的read()读取所返回的内容
'''
total 4
-rw-rw-r-- 1 tengjian tengjian  0 11月  5 09:32 a.txt
-rw-rw-r-- 1 tengjian tengjian 81 11月  5 09:32 python_shell.py
'''
```

对于那些没有返回指的shell命令，我依然也可以使用popen()方法，如下：

```
import os
 
f=os.popen("touch b.txt")    # 创建一个文件
# f=os.popen("mkdir newdir") # 创建一个新的文件夹
print(f.read())              # 无返回值

```

**三、subprocess.Popen()

shlex.split() 可以用来格式化字符串，按照空格将其分割处理。原始的字符串中可能有多个空格的情况，处理之后都可以正确分割。分割之后的值可以直接送到 sp.Popen() 运行

    cmd = "curl -X GET --header 'Accept: application/json' 'http://127.0.0.1:8181/onos/v1/zy/zy/bandwith' --user onos:rocks"
    args = shlex.split(cmd)
    process = subprocess.Popen(args, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

## re 正则表达式



```
import re
reg=re.compile(r"(?<=指定字符)\d+")
match=reg.search("待查找文本")
print match.group(0)
```

```python
#!/usr/bin/python3
 
s = '  -----abc123++++       '
 
# 删除两边空字符
print(s.strip())
 
# 删除左边空字符
print(s.rstrip())
 
# 删除右边空字符
print(s.lstrip())
 
# 删除两边 - + 和空字符
print(s.strip().strip('-+'))
 
print("北门吹雪:http://www.cnblogs.com/2bjiujiu/")

 
# 去除字符串中相同的字符
s = '\tabc\t123\tisk'
print(s.replace('\t', ''))
 
print("北门吹雪: http://www.cnblogs.com/2bjiujiu/")
 
import re
# 去除\r\n\t字符
s = '\r\nabc\t123\nxyz'
print(re.sub('[\r\n\t]', '', s))
```

## Python 时间处理

```python
import datetime
if __name__ == '__main__':    				
    print(datetime.datetime.now().strftime('%F %T'))    	
    print((datetime.datetime.now() - datetime.timedelta(days=1)).strftime("%Y-%m-%d %H:%M:%S")) 
    print((datetime.datetime.now() + datetime.timedelta(days=1)).strftime("%Y-%m-%d %H:%M:%S"))
```

## 删除数组

remove: 删除单个元素，删除首个符合条件的元素，按值删除
举例说明:

```python
>>> str=[1,2,3,4,5,2,6]``
>>> str.remove(2)`
>>> str
```

输出

```
[1, 3, 4, 5, 2, 6]
```

2.pop: 删除单个或多个元素，按位删除(根据索引删除)

```
>>> str=[0,1,2,3,4,5,6]``>>> str.pop(1) #pop删除时会返回被删除的元素``>>> str
```

输出

```
[0, 2, 3, 4, 5, 6]
>>> str2=['abc','bcd','dce']``>>> str2.pop(2)
'dce'``>>> str2``['abc', 'bcd']
```

3.del：它是根据索引(元素所在位置)来删除
举例说明:

```
>>> str=[1,2,3,4,5,2,6]``>>> del str[1]``>>> str
```

输出

```
[1, 3, 4, 5, 2, 6]
```

## python 2 的坑

#### 1 with open

```pytho
python3 :
with open('XXX','r',encoding='utf-8') as f:
	f.read()
	
python2:
import io
with io.open(file_name, 'r', encoding='utf-8') as file:
        file.read()
```

#### 2 json.loads

```python
python2 中 json.loads()会将编码自动改为Unicode
自定义转译函数
def unicode_convert(input):
    if isinstance(input, dict):
        return {unicode_convert(key): unicode_convert(value) for key, value in input.iteritems()}
    elif isinstance(input, list):
        return [unicode_convert(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input

```

## python debug

```python
import pdb


命令	命令全称	功能
h	help	查看帮助
n	next	执行下一条语句
s	step	执行下一条语句，如果是函数，则会执行到函数的第一句
b	break	列出当前的所有断点
b <行号>	/	在某一行打一个断点
b <文件名>:<行号>	/	在某个文件的某行打一个断点
b <函数名>	/	在某个函数的第一行打一个断点
cl	clear	清除所有断点
cl n1 n2 ...	/	清除编号为n1、n2...的断点
cl <行号>	/	清除某行的断点
cl <文件名>:<行号>	/	清除某个文件某行的断点
r	return	执行当前函数到结束
c	continue	执行到下一个断点
l	list	列出源码（前后11行代码）
l <行号>	/	列出某行周围11行代码
l <行号1> <行号2>	/	列出两个行号范围内的代码
p <变量名>	print <变量名>	输出变量的值
pp <变量名>	/	好看一点的输出
q	quit	退出debug
unt	until	退出循环或当期堆栈
run	/	重新启动debug
a	args	列出当前执行的函数的参数
w	where	打印当前执行堆栈

```



## 处理XML文档

#### xml.etree.ElementTree

```python

>>> import xml.etree.cElementTree as ET
>>> tree = ET.ElementTree(file='doc1.xml')     #载入数据
>>> root = tree.getroot()     #获取根节点
<Element 'doc' at 0x11eb780>

<tag attrib1=1>text</tag>tail
ET使用Element表示xml中的节点、文本、注释等。其主要属性如下：
tag：string对象，表示数据代表的种类，当为节点时为节点名称。
text：string对象，表示element的内容。
attrib：dictionary对象，表示附有的属性。
tail：string对象，表示element闭合之后的尾迹。



```

```python
class xml.etree.ElementTree.Element(tag, attrib={}, **extra)

  tag:string      元素代表的数据种类。
  text:string     元素的内容。
  tail:string      元素的尾形。
  attrib:dictionary     元素的属性字典。
 
  ＃针对属性的操作
  clear()          清空元素的后代、属性、text和tail也设置为None。
  get(key, default=None)     获取key对应的属性值，如该属性不存在则返回default值。
  items()         根据属性字典返回一个列表，列表元素为(key, value）。
  keys()           返回包含所有元素属性键的列表。
  set(key, value)     设置新的属性键与值。

  ＃针对后代的操作
  append(subelement)     添加直系子元素。
  extend(subelements)    增加一串元素对象作为子元素。＃python2.7新特性
  find(match)                  寻找第一个匹配子元素，匹配对象可以为tag或path。
  findall(match)               寻找所有匹配子元素，匹配对象可以为tag或path。
  findtext(match)             寻找第一个匹配子元素，返回其text值。匹配对象可以为tag或path。
  insert(index, element)   在指定位置插入子元素。
  iter(tag=None)              生成遍历当前元素所有后代或者给定tag的后代的迭代器。＃python2.7新特性
  iterfind(match)              根据tag或path查找所有的后代。
  itertext()                       遍历所有后代并返回text值。
  remove(subelement)      删除子元素。
```

## 进制转换

  二进制 bin（） ob
  八进制 oct（） 0o
  十六进制 hex（） 0x

```python
# 10进制转为2进制
print(bin(10))
# 结果：0b1010

# 2进制转为10进制
print(int("1001", 2))
# 结果：9

# 10进制转为16进制
print(hex(10))
# 结果：0xa

# 16进制到10进制
print(int('ff', 16))
# 结果：255

print(int('0xab', 16))
# 结果：171

# 16进制到2进制
print(bin(0xa))
# 结果：0b1010

# 10进制到8进制
print(oct(8))
# 结果：0o10

# 2进制到16进制
print(hex(0b1001))
# 结果：0x9

```

### 将数字补全

```python
'''
原字符串左侧对齐， 右侧补零:
'''
str.ljust(width,'0') 
input: '789'.ljust(32,'0')
output: '78900000000000000000000000000000'


'''
原字符串右侧对齐， 左侧补零:
方法一：
'''
str.rjust(width,'0') 
input: '798'.rjust(32,'0')
output: '00000000000000000000000000000798'
'''
方法二：
'''
str.zfill(width)
input: '123'.zfill(32)
output:'00000000000000000000000000000123'
'''
方法三：
'''
'%07d' % n
input: '%032d' % 89
output:'00000000000000000000000000000089'

```

```
switch = hex(int(text[1])).replace('0x', '').zfill(16)
```



## 异常处理

```python
try:
    可能产生异常的代码块
except [ (Error1, Error2, ... ) [as e] ]:
    处理异常的代码块1
except [ (Error3, Error4, ... ) [as e] ]:
    处理异常的代码块2
except  [Exception]:
    处理其它异常

 try:
    正常的操作
   ......................
except(Exception1[, Exception2[,...ExceptionN]]]):
   发生以上多个异常中的一个，执行这块代码
   ......................
else:
    如果没有异常执行这块代码
    
 try:
<语句>
finally:
<语句>    #退出try时总会执行
raise
```

## 获取当前路径

在使用python的时候总会遇到路径切换的使用情况，如想从文件夹test下的`test.py`调用data文件夹下的`data.txt`文件：

```
.
└── folder
    ├── data
    │   └── data.txt
    └── test
        └── test.py123456
```

一种方法可以在data文件下加入`__init__.py` 然后在`test.py` 中`import data` 就可以调用`data.txt`文件；

另一种方法可以借助python os模块的方法对目录结构进行操作，下面就说一下这种方式的使用：

```
import os

print '***获取当前目录***'
print os.getcwd()
print os.path.abspath(os.path.dirname(__file__))

print '***获取上级目录***'
print os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
print os.path.abspath(os.path.dirname(os.getcwd()))
print os.path.abspath(os.path.join(os.getcwd(), ".."))

print '***获取上上级目录***'
print os.path.abspath(os.path.join(os.getcwd(), "../.."))12345678910111213
```

输出结果为：

```
***获取当前目录***
/workspace/demo/folder/test
/workspace/demo/folder/test

***获取上级目录***
/workspace/demo/folder
/workspace/demo/folder
/workspace/demo/folder

***获取上上级目录***
/workspace/demo
```

## split join

![img](https://iknow-pic.cdn.bcebos.com/9345d688d43f8794f76f0ff0d91b0ef41ad53a5f?x-bce-process=image/resize,m_lfit,w_600,h_800,limit_1)





在字典遍历过程中修改字典元素，报错 RuntimeError: dictionary changed size during iteration

得知遍历时不能修改字典元素

```python
for k in func_dict.keys():
    if func_dict[k] is np.nan:
        del func_dict[k]
        continue
```

## python 深拷贝与浅拷贝

### **数字和字符串**

数字和字符串中的内存都指向同一个地址，所以深拷贝和浅拷贝对于他们而言都是无意义的

 

```python
import copy
 
a = 123                #赋值
 
print(id(a))           #输出存储变量的地址
 
b = a
 
print(id(b))
 
b = copy.copy(a)       #浅拷贝
 
print(id(b))
 
c = copy.deepcopy(a)  #深拷贝
 
print(id(c))
```

　![img](https://images2015.cnblogs.com/blog/1064640/201611/1064640-20161123165509221-937695593.png)

###  **浅拷贝**

对于字典 元组 和列表来说，进行浅拷贝和深拷贝时，内存的地址是不同的

浅拷贝只会拷贝内存中的第一层数据

```
import copy
 
dic = {'key1':123,'key2':[123,456]}            #创建一个字典嵌套列表
 
print(id(dic['key1']))
print(id(dic['key2']))
print(id(dic['key2'][0]))                      #打印列表中的地址
 
print("\n")
 
new_dic = copy.copy(dic)                       #使用浅拷贝赋值
 
print("*",id(new_dic['key1']))
print("*",id(new_dic['key2']))
print("*",id(new_dic['key2'][0]))<br><br><br>
```

![img](https://images2015.cnblogs.com/blog/1064640/201611/1064640-20161123174301956-861202388.png)

发现内存中地址的值都是完全相同

###  **深拷贝**

而对于深拷贝来说将会把所有数据重新创建

```
import copy
 
dic = {'key1':123,'key2':[123,456]}            #创建一个字典嵌套列表
 
print(id(dic['key1']))
print(id(dic['key2']))
print(id(dic['key2'][0]))                      #打印列表中的地址
 
print("\n")
 
new_dic = copy.deepcopy(dic)                       #使用深拷贝赋值
 
print("*",id(new_dic['key1']))
print("*",id(new_dic['key2']))
print("*",id(new_dic['key2'][0]))
```

![img](https://images2015.cnblogs.com/blog/1064640/201611/1064640-20161123175556050-1673452907.png)

###  **深拷贝的应用**

在浅拷贝中 当改变拷贝对象的值 被拷贝对象的值也会随之改变

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
import copy

dic = {'key1':123,'key2':[123,456]}            #创建一个字典嵌套列表


print(dic['key2'][0])                          #打印列表中的地址

print("\n")

new_dic = copy.copy(dic)                       #使用浅拷贝赋值 

new_dic['key2'][0] = 789                       #改变字典中列表的值

print(dic['key2'][0])
print((new_dic['key2'][0]))
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![img](https://images2015.cnblogs.com/blog/1064640/201611/1064640-20161123180600737-444055284.png)

 

当不想改变被拷贝的值时 应该使用深拷贝

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
import copy

dic = {'key1':123,'key2':[123,456]}            #创建一个字典嵌套列表


print(dic['key2'][0])                          #打印列表中的地址

print("\n")

new_dic = copy.deepcopy(dic)                       #使用深拷贝赋值 

new_dic['key2'][0] = 789                       #改变字典中列表的值

print(dic['key2'][0])
print((new_dic['key2'][0]))
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 ![img](https://images2015.cnblogs.com/blog/1064640/201611/1064640-20161123180745440-472188263.png)

 

## screen

screen 是一个特殊的模拟终端软件，利用它能在一个终端窗口里模拟出多个终端
并且能分割窗口、类似 VI 的方式搜索和拷贝屏幕输出，最重要的是利用
screen，可以让任务后台执行，退出系统，下次登录恢复后跟以前状态一样

参　　数：
　-A 　将所有的视窗都调整为目前终端机的大小。 
　-d<作业名称> 　将指定的screen作业离线。 
　-h<行数> 　指定视窗的缓冲区行数。 
　-m 　即使目前已在作业中的screen作业，仍强制建立新的screen作业。 
　-r<作业名称> 　恢复离线的screen作业。 
　-R 　先试图恢复离线的作业。若找不到离线的作业，即建立新的screen作业。 
　-s<shell> 　指定建立新视窗时，所要执行的shell。 
　-S<作业名称> 　指定screen作业的名称。 
　-v 　显示版本信息。 
　-x 　恢复正在工作的screen作业。 
　-ls或--list 　显示目前所有的screen作业。 
　-wipe 　检查目前所有的screen作业，并删除已经无法使用的screen作业

## 浮点数的精度

比较简单的处理方式，精度比较差

```
round()如果只有一个数作为参数，不指定位数的时候，返回的是一个整数，而且是最靠近的整数（这点上类似四舍五入）。但是当出现.5的时候，两边的距离都一样，round()取靠近的偶数，这就是为什么round(2.5) = 2。当指定取舍的小数点位数的时候，一般情况也是使用四舍五入的规则，但是碰到.5的这样情况，如果要取舍的位数前的小树是奇数，则直接舍弃，如果偶数这向上取舍。看下面的示例：
>>> round(2.635, 2)
2.63
>>> round(2.645, 2)
2.65
>>> round(2.655, 2)
2.65
>>> round(2.665, 2)
2.67
>>> round(2.675, 2)
2.67
```