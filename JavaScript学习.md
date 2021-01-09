# **一：JavaScript学习**

## 1.使用JavaScript

内部使用：

```html
<script>
    alert('hello word')
</script>
```

外部引用

```html
 <script src="../static/js/learn01.js"></script>
```

script放在body与head里的区别

放在body中：在页面加载的时候被执行

放在head中：在被调用时被执行

```
 1，在head中时，所代表的functions只加载而不执行，执行是在某一事件触发后才开始。
  2，在body中时，直接加载并执行
```

## 2 基本语法

### 2.1 对象与数组

```html
<script>
    //数组用[]
    var myarr=[1,2,'a','b']
    console.log(myarr[3])
    //对象用{}
    var myobj={
        name:'zhoayu',
        age:23,
        hobby:['eat','sleep']
    }
    console.log(myobj['name'])
</script>
```

### 删除数组元素

```
自定义删除函数
Array.prototype.removeByValue = function(val) {
  for(var i=0; i<this.length; i++) {
    if(this[i] == val) {
      this.splice(i, 1);
      break;
    }
  }
}
var somearray = ["mon", "tue", "wed", "thur"]
somearray.removeByValue("tue");
//somearray will now have "mon", "wed", "thur"
```

### 2.2 变量

```html
{#使用严格审查模式 use strict，避免JavaScript随意性导致的错误。
 ES6 中建议使用let 表示局部变量，用const表示常量
 #}
<script>
    'use strict';
    i=1;//报错
    let a=1;
    const b=2;
</script>
```

JS中：=赋值

​			==表示数值一样

​	   	===表示类型一样，数值一样（尽量使用）

### 2.3字符串

```html
<script>
    let name='zhaoyu'//js中字符串与Java一样不可变
    let msg=`你好，${name}
    欢迎
    回来`//使用反引号可以写多行字符，${name}
    console.log(name.length)//字符长度
    console.log(name.indexOf('z'))//返回字符z出现的位置
    console.log(name.substring(1,3))//从[1,3)截取字符
    console.log(name.toUpperCase())//大写
</script>

```

#### 2.3.1 取出字符串中的字母与数字（正则）

```
i  是一个修饰符 (搜索不区分大小写)。
[^\]表示任何非
取出数字
var a = 'testAbc123def'; 
b = a.replace(/[^0-9]+/ig,"");
alert(b);
‘123’

取出字母
b = a.replace(/[^a-z]+/ig,"");
alert(b);
提取中文
a.replace(/[^\u4E00-\u9FA5]/g,'')

去除字符中的数字
a.replace(/\d+/g,'')

var re = /(\D+)/
var r = re.exec('kjjd12-s2')[0]
r = kjjd
```

#### 2.32. 使用模式

#####  使用简单模式

简单的模式是由找到的直接匹配所构成的。比如，/abc/这个模式就匹配了在一个字符串中，仅仅字符 'abc' 同时出现并按照这个顺序。在 "Hi, do you know your abc's?" 和 "The latest airplane designs evolved from slabcraft." 就会匹配成功。在上面的两个实例中，匹配的是子字符串 'abc'。在字符串 "Grab crab" 中将不会被匹配，因为它不包含任何的 'abc' 子字符串。

##### 使用特殊字符

例如：模式/ab*c/匹配了一个单独的 'a' 后面跟了零个或者多个 'b'（*的意思是前面一项出现了零个或者多个），且后面跟着 'c' 的任何字符组合。在字符串 "s'scbbabbbbcdebc" 中，这个模式匹配了子字符串 "abbbbc"。

| 字符   | 含义                                                         |
| ------ | ------------------------------------------------------------ |
| \      | 匹配将依照下列规则： 在非特殊字符之前的反斜杠表示下一个字符是特殊的，不能从字面上解释。例如，前面没有''的'd'通常匹配小写'd'。如果加了'',这个字符变成了一个特殊意义的字符，意思是匹配一个数字。 反斜杠也可以将其后的特殊字符，转义为字面量。例如，模式 /a*/ 代表会匹配 0 个或者多个 a。相反，模式 /a\*/ 将 '*' 的特殊性移除，从而可以匹配像 "a*" 这样的字符串。 使用 new RegExp("pattern") 的时候也不要忘记将 \ 进行转义，因为 \ 在字符串里面也是一个转义字符。 |
| ^      | 匹配输入的开始，例如，`/^A/` 并不会匹配 "an A" 中的 'A'，但是会匹配 "An E" 中的 'A'。 |
| $      | 匹配输入的结束。例如，/t$/ 并不会匹配 "eater" 中的 't'，但是会匹配 "eat" 中的 't'。 |
| *      | 匹配前一个表达式0次或多次。等价于 {0,}。例如，/bo*/会匹配 "A ghost boooooed" 中的 'booooo' |
| +      | 匹配前面一个表达式1次或者多次。等价于 {1,}。例如，/a+/匹配了在 "candy" 中的 'a'，和在 "caaaaaaandy" 中所有的 'a'。 |
| ?      | 匹配前面一个表达式0次或者1次。等价于 {0,1}。例如，/e?le?/ 匹配 "angel" 中的 'el'，和 "angle" 中的 'le' 以及"oslo' 中的'l'。 如果紧跟在任何量词 *、 +、? 或 {} 的后面，将会使量词变为非贪婪的（匹配尽量少的字符），和缺省使用的贪婪模式（匹配尽可能多的字符）正好相反。 例如，对 "123abc" 应用 /\d+/ 将会返回 "123"，如果使用 /\d+?/,那么就只会匹配到 "1"。 |
| .      | 匹配除换行符之外的任何单个字符。例如，/.n/将会匹配 "nay, an apple is on the tree" 中的 'an' 和 'on'，但是不会匹配 'nay'。 |
| x      | y                                                            |
| {n}    | n是一个正整数，匹配了前面一个字符刚好发生了n次。 比如，/a{2}/不会匹配“candy”中的'a',但是会匹配“caandy”中所有的a，以及“caaandy”中的前两个'a'。 |
| {n,m}  | n 和 m 都是整数。匹配前面的字符至少n次，最多m次。如果 n 或者 m 的值是0， 这个值被忽略。例如，/a{1, 3}/ 并不匹配“cndy”中的任意字符，匹配“candy”中的a，匹配“caandy”中的前两个a，也匹配“caaaaaaandy”中的前三个a。注意，当匹配”caaaaaaandy“时，匹配的值是“aaa”，即使原始的字符串中有更多的a。 |
| [xyz]  | 一个字符集合。匹配方括号中的任意字符，包括转义序列。你可以使用破折号（-）来指定一个字符范围。对于点（.）和星号（*）这样的特殊符号在一个字符集中没有特殊的意义。他们不必进行转义，不过转义也是起作用的。 例如，[abcd] 和[a-d]是一样的。他们都匹配"brisket"中的‘b’,也都匹配“city”中的‘c’。/[a-z.]+/ 和/[\w.]+/与字符串“test.i.ng”匹配。 |
| [^xyz] | 一个反向字符集。也就是说， 它匹配任何没有包含在方括号中的字符。你可以使用破折号（-）来指定一个字符范围。任何普通字符在这里都是起作用的。 |
| \b     | 匹配一个词的边界。一个词的边界就是一个词不被另外一个“字”字符跟随的位置或者没有其他“字”字符在其前面的位置。注意，一个匹配的词的边界并不包含在匹配的内容中。换句话说，一个匹配的词的边界的内容的长度是0。例如： /\bm/匹配“moon”中的‘m’；/oo\b/并不匹配"moon"中的'oo'，因为'oo'被一个“字”字符'n'紧跟着。/oon\b/匹配"moon"中的'oon'，因为'oon'是这个字符串的结束部分。这样他没有被一个“字”字符紧跟着。 |
| \d     | 匹配一个数字。等价于[0-9]。例如， /\d/ 或者 /[0-9]/ 匹配"B2 is the suite number."中的'2'。 |
| \D     | 匹配一个非数字字符。等价于[^0-9]。例如， /\D/ 或者 /[^0-9]/ 匹配"B2 is the suite number."中的'B' 。 |
| \f     | 匹配一个换页符 (U+000C)。                                    |
| \n     | 匹配一个换行符 (U+000A)。                                    |
| \r     | 匹配一个回车符 (U+000D)。                                    |
| \s     | 匹配一个空白字符，包括空格、制表符、换页符和换行符。等价于[ \f\n\r\t\v\u00a0\u1680\u180e\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]。 例如, /\s\w*/ 匹配"foo bar."中的' bar'。 |
| \S     | 匹配一个非空白字符。等价于[^ \f\n\r\t\v\u00a0\u1680\u180e\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]。 例如， /\S\w*/ 匹配"foo bar."中的'foo'。 |
| \t     | 匹配一个水平制表符 (U+0009)。                                |
| \w     | 匹配一个单字字符（字母、数字或者下划线）。等价于[A-Za-z0-9_]。 例如, /\w/ 匹配 "apple," 中的 'a'，"$5.28,"中的 '5' 和 "3D." 中的 '3'。 |
| \W     | 匹配一个非单字字符。                                         |
| \n     | 在正则表达式中，它返回最后的第n个子捕获匹配的子字符串(捕获的数目以左括号计数)。 |

####  应用

#####  切分字符串

用正则表达式切分字符串比用固定的字符更灵活，通常的切分代码：

```
'a d   c'.split(' '); // ['a', 'd', '', '', 'c']
```

上面方法无法识别连续的空格，改用正则表达式：

```
'a b   c'.split(/\s+/); // ['a', 'b', 'c']
```

无论多少个空格都可以正常分割。再加入‘,’：

```
'a,b, c  d'.split(/[\s\,]+/); // ['a', 'b', 'c', 'd']
```

再加入;：

```
'a,b;; c  d'.split(/[\s\,\;]+/); // ['a', 'b', 'c', 'd']
```

所以，可以用正则表达式来把不规范的输入转化成正确的数组。

##### 分组

除了判断是否匹配之外，正则表达式还可以提取子串，用()表示的就是要提取的分组（Group）。比如：

`^(\d{4})-(\d{4,9})$`分别定义了两个组，可以直接从匹配的字符串中提取出区号和本地号码：

```
var re = /^(\d{4})-(\d{4,9})$/;
re.exec('0530-12306'); // ['010-12345', '010', '12345']
re.exec('0530 12306'); // null
```

exec()方法在匹配成功后，返回一个数组，第一个元素是正则表达式匹配到的整个字符串，后面的字符串表示匹配成功的子串。

exec()方法在匹配失败时返回null。

#####  贪婪匹配

注意，正则匹配默认是贪婪匹配，也就是匹配尽可能多的字符。如下，匹配出数字后面的0：

```
var re = /^(\d+)(0*)$/;
re.exec('102300'); // ['102300', '102300', '']
```

由于`\d+`采用贪婪匹配，直接把后面的`0`全部匹配了，结果`0*`只能匹配空字符串了。

必须让`\d+`采用非贪婪匹配（也就是尽可能少匹配），才能把后面的`0`匹配出来，加个`?`就可以让`\d+`采用非贪婪匹配：

```
var re = /^(\d+?)(0*)$/;
re.exec('102300'); // ['102300', '1023', '00']
```

#####  正则表达式标志

```
g	全局搜索。
i	不区分大小写搜索。
m	多行搜索。
y	执行“粘性”搜索,匹配从目标字符串的当前位置开始，可以使用y标志。
```

#####  test() 方法

test() 方法用于检测一个字符串是否匹配某个模式，如果字符串中含有匹配的文本，则返回 true，否则返回 false。

```
var re = /^(\d{4})-(\d{4,9})$/;
re.test('0530-12321'); // true
re.test('0530-123ab'); // false
re.test('0530 12321'); // false
```

####  常用正则（参考）

```
验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
验证身份证号（15位或18位数字）：^\d{15}|\d{}18$

中国大陆手机号码：1\d{10}
中国大陆固定电话号码：(\d{4}-|\d{3}-)?(\d{8}|\d{7})
中国大陆邮政编码：[1-9]\d{5}

IP地址：((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)

日期(年-月-日)：(\d{4}|\d{2})-((1[0-2])|(0?[1-9]))-(([12][0-9])|(3[01])|(0?[1-9]))
日期(月/日/年)：((1[0-2])|(0?[1-9]))/(([12][0-9])|(3[01])|(0?[1-9]))/(\d{4}|\d{2})


验证数字：^[0-9]*$
验证n位的数字：^\d{n}$
验证至少n位数字：^\d{n,}$
验证m-n位的数字：^\d{m,n}$
验证零和非零开头的数字：^(0|[1-9][0-9]*)$
验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
验证非零的正整数：^\+?[1-9][0-9]*$
验证非零的负整数：^\-[1-9][0-9]*$
验证非负整数（正整数 + 0） ^\d+$
验证非正整数（负整数 + 0） ^((-\d+)|(0+))$
验证长度为3的字符：^.{3}$
验证由26个英文字母组成的字符串：^[A-Za-z]+$
验证由26个大写英文字母组成的字符串：^[A-Z]+$
验证由26个小写英文字母组成的字符串：^[a-z]+$
验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
```

### 2.4数组

```html
<script>
    //定义数组,
    let myarr=['1','2','3','a','b']//数组可变
    //取值
    myarr[1];
    myarr.slice(1,3)//截取数组的一部分，类似于string中的substring
    myarr.pop();//数组尾部弹出
    myarr.push();//数组尾部添加
    myarr.unshift()//数组头部添加
    myarr.shift()//数组头部弹出
    myarr.sort()//排序
    myarr.reverse()//元素翻转
    myarr.concat(['c','d'])//拼接一个字符串，但不改变原来的字符串
    myarr.join('-')
	//"a-3-2"
</script>

```

数组遍历的方法

```html

let myarr = ['1', '2', '3', 'a', 'b']
    console.log(myarr)
//经典for循环
    for (let i=0;i<myarr.length;i++){
        console.log(myarr[i])
    }
//for in                                      
    for (i in myarr) {
        console.log(myarr[i])
    }
// for of                                      
    for (let array of myarr) {
        console.log(array)
    }
//forEach                                      
    myarr.forEach((i)=>{
        console.log(i)
    })

```

### 2.5 map and set

```html
<script>
    'use strict'
    //map ES6 新特性，类似于字典
    let  map=new Map([['tom',100],['jary',[80,70]],['jack',10]])
    let tom_score=map.get('tom')
    map.set('jj',88)
    map.delete('jj')
    //set 无序不重复集合
    let set =new Set([3,1,1,1])//自动去重
    set.add(2)
    set.delete(3)
    set.has(1)//是否有这个值
</script>
```

## 3 函数

函数定义

```html
//方式一
function abs(x) {
        if (x > 0) {
            return x
        } else {
            return -x
        }
    }
//方式二
let abs = function (x) {
        if (x > 0) {
            return x
        } else {
            return -x
        }
    }
```

Java函数可以传递多个参数，可以用...rest承接多余的参数

```html 
function abs(x, ...rest) {
        if (x > 0) {
            console.log(arguments.length)//参数的个数
            console.log(rest)
            return x
        } else {
            return -x
        }
    }
```

变量作用域

子函数的变量可以调用父函数的变量，反之不行

```javascript
function f() {
        let x=1
        function f1() {
            let y=x+1//y=2
        }
        let z=y+1//报错
    }
```

当子函数的变量与父函数的变量重名，子函数使用自己的变量。变量定义由内向外

```javas
function f() {
        let x=1
        function f1() {
            let x='a'
            console.log(x)//输出a
        }
    }
```

全局变量自动绑定到window

```javas
<script>
    //定义一个全局变量
    let x=1
    // console.log(x)等价于console.log(window.x)
</script>
```

由于全局变量自动绑定到window，为了避免引用多个js文件造成混乱建议唯一全局变量减少冲突

```javas
<script>
    //唯一全局变量
    let myapp={};
    myapp.x=1;
    myarr.abs=function (x) {
        console.log(x)
    }
</script>
```

const 常量

## 4 方法

方法的定义

```javascript
let info={
        name:'zhoayu',
        birth:2000,
        //方法：在对象中定义的函数
        age:function () {
            let now=new Date().getFullYear()
            return now-this.birth
        }
    }
info.name
info.age()
```

外部引用

```javascript
<script>
    function getAge(){
        let now=new Date().getFullYear()
            return now-this.birth
    }
    let info={
        name:'zhoayu',
        birth:2000,
        //方法：在对象中定义的函数
        age:getAge
    }
    info.age()//调用方法
    getAge.apply(info,[])//使用apply调用某个对象的方法，反射机制
</script>
```

### 时间类

```javascript
let now =new Date()
    now.getFullYear()//年
    now.getMonth()//月
    now.getDate()//日
    now.getDay()//星期
    now.getTime()//获取时间戳
//
now.getTime()
1588759145799
//
new Date(1588759145799)
Wed May 06 2020 17:59:05 GMT+0800 (中国标准时间)
//
now.toLocaleTimeString()
"下午5:59:05"
//
now.toLocaleString()
"2020/5/6 下午5:59:05"
```

### json

```javascript
//js对象
    let info={
        name:'zhoayu',
        age:'10'
    }
    //将js对象转化为json
    let jsoninfo=JSON.stringify(info)//"{"name":"zhoayu","age":"10"}"
    //将json转化为js对象
    let infomation=JSON.parse('{"name":"zhoayu","age":"10"}')
```

## 5 类

```html 
//定义一个类 
class student{
        constructor(name,age) {
            this.name=name
            this.age=age
        }
        hello(){
            return 'hello'
        }
    }
    let zy=new student('zhaoyu',22)
//继承
    class seniorStudent extends student{
        constructor(name,age,gender) {
            super(name,age);
           this.gender=gender
        }
        eat()
        {
            console.log('eat')
        }
    }
    let zz=new seniorStudent('zhaoyu',22,'男')
```

## 6 DOM

```html
<p id="mp">myppp</p>
<div id="father">
    <p id="p1">hello</p>
    <p class="c1">word</p>
    <h1>zhoayu</h1>
</div>
<script>
    //获取DOM节点
    let p1=document.getElementById('p1')
    let c1=document.getElementsByClassName('c1')
    let h1=document.getElementsByTagName('h1')
    //更新节点
    p1.innerText='nohello'//修改文本
    p1.innerHTML='<input type="button"/>'//修改节点
    p1.style.color='red'
    p1.style.fontSize='10px'
    //删除节点--先找到父节点，通过父节点删除此节点
    let self=document.getElementById('p1')
    let father=self.parentElement
    father.removeChild(self)
    //按照下标删除子节点,注意删除时尽量从后向前删，应为删除是动态的，长度一直在变
    father.removeChild(father.children[2])
    father.removeChild(father.children[1])
    father.removeChild(father.children[0])
    //插入节点
    let newp=document.createElement('p')//创建一个新节点
    newp.setAttribute('id','newp')//设置属性
    newp.innerText='new p'
    father.appendChild(newp)//将新节点加入到father节点下（尾部）


</script>
```

## 7 jQuery

```html
//引用在线的jQuery库
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.0/jquery.js"></script>
```

```html
//jquery  公式--$(选择器).action()
<a href="" id="jqa">点击</a>
//选择器就是CSS选择器
<script>
    $('#jqa').click(function () {
        alert('hello jquery')
    })
</script>
	$('p')//标签选择器
    $('.class')//类选择器
    $('#id1')//id选择器
```

#### 7.1: 事件

键盘事件，鼠标事件，其他事件

```html
mouse:<span id="mouse_coordinate"></span>
<div id="boundary">
    在这里移动鼠标
</div>
<script>
    $(function () {
            $('#boundary').mousemove(function (e) {
                $('#mouse_coordinate').text('x'+e.pageX)

            })
        }
    )
</script>

```

#### 7.2 JQuery 获取div的值

text();设置或者获取所选元素的文本内容；

html();设置或者获取所选元素的内容（包括html标记）；

val();设置或者获取表单字段的值（前提是表单设置了value属性）；

(text()和html()的区别是：前者是处理的文本内容，只能写文本如果写了上面的标记则会以文本形式输出；后者可以解析文本中的html标记，就是你可以添加像<a></a>、<p></p>等标记，最后会解析为其效果。
)



```
$("#business").text($(obj).find("span").text()) 
将business的文字改成span的文字
```

*JavaScript中设置或者获取所选内容的值

同理innerText、innerHTML和value

input输入框的值用value取

## 定时器setInterval的启动与停止

```
function func(){console.log("print")} //定时任务
var interval = setInterval(func, 2000); //启动,func不能使用括号
clearInterval(interval );//停止
interval = setInterval(func, 2000); //重新启动即可
```

# 二：HTML

## 1 ：排版

### 1：元素并列

设置浮动

```js
#div1{
	width:50%;
	height:300px;
	background:blue;
	float:left;
}
#div2{
	width:50%;
	height:300px;
	background:green;
	float:left;
}
```

### 2：居中

```html
        <div style="height:100px;width: 170px;padding: 0;float: left;text-align: center;">
            <div class="alert alert-primary" role="alert"
                 style="height: 50px;width: 140px; text-align: center;display: inline-block;margin-top: 30px">
                业务展示
            </div>
        </div>
```

父节点：text-align:center

子节点：display：inline-block

### 3：点击按钮删除父节点

```ht
onclick="stop_business(this)"
function stop_business(obj) {
            $(obj).parent().remove()
        }
        
```

### 4：删除子节点

```javascript

<div id="top"> 
    <div>
        这是孙辈元素
        <li>孙代的li-1</li>
        <li>孙代的li-2</li>
        <li>孙代的li-3</li>
    </div>
    <span>子代的span</span>
    <li>子代的li-1</li>
    <li>子代的li-2</li>
    <li>子代的li-3</li>   
</div>
<input type="button" value="点我删除子代的li" name="btn1">
<input type="button" value="点我删除子代所有元素" name="btn2">

$(function(){
    $("input[name='btn1']").click(function() {
        $("#top").children('li').remove();
    });
    $("input[name='btn2']").click(function() {
        $("#top").children().remove();
    });
})
```



### 5：字符串中过滤空格换行

```htm
$("#accuracy").val($("#accuracy").val().replace(/\ +/g,""));//去掉空格
$("#content").val($("#content").val().replace(/[ ]/g,""));    //去掉空格
$("#content").val($("#content").val().replace(/[\r\n]/g,""));//去掉回车换行
```

### 6: 关闭，开启ajax异步操作

```html
$.ajaxSettings.async = false;
$.get()
$.get()
$.ajaxSettings.async = true;#重新开启，避免影响其他操作
```

### 7:使用css设置滚动条

设置元素高度，设置overflow属性为auto，当高度超过设置的高度时就会出现滚动条。

水平滚动overflow-x：auto，垂直滚动overflow-y:auto

```javascript
<ul class="bar",style="height:100px,overflow=auto">
    <li></li>
    <li></li>	
</ul>
```

### 8: 设置复选框

```html
<!DOCTYPE html>
<html lang="zh-CN">
 
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
		<title>表格</title>
		<meta name="keywords" content="表格">
		<meta name="description" content="这真的是一个表格" />
		<meta name="HandheldFriendly" content="True" />
		<link rel="shortcut icon" href="img/favicon.ico">
		<!-- Bootstrap3.3.5 CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
 
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
    		<script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    		<script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    	<![endif]-->
	</head>
 
	<body>
		<div class="panel-group">
			<div class="panel panel-primary">
				<div class="panel-heading">
					列表
				</div>
				<div class="panel-body">
					<div class="list-op" id="list_op">
						<button type="button" class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
						</button>
						<button type="button" class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
						</button>
						<button type="button" class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
						</button>
					</div>
				</div>
				<table class="table table-bordered table-hover">
					<thead>
						<tr class="success">
							<th>类别编号</th>
							<th>类别名称</th>
							<th>类别组</th>
							<th>状态</th>
							<th>说明</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>C00001</td>
							<td>机车</td>
							<td>机车</td>
							<td>有效</td>
							<td>机车头</td>
						</tr>
						<tr>
							<td>C00002</td>
							<td>车厢</td>
							<td>机车</td>
							<td>有效</td>
							<td>载客车厢</td>
						</tr>
					</tbody>
				</table>
				<div class="panel-footer">
					<nav>
						<ul class="pagination pagination-sm">
    						<li class="disabled">
      							<a href="#" aria-label="Previous">
        							<span aria-hidden="true">«</span>
      							</a>
    						</li>
    						<li class="active"><a href="#">1</a></li>
						    <li><a href="#">2</a></li>
						    <li><a href="#">3</a></li>
						    <li><a href="#">4</a></li>
						    <li><a href="#">5</a></li>
    						<li>
						    	<a href="#" aria-label="Next">
						    		<span aria-hidden="true">»</span>
						    	</a>
    						</li>
						</ul>
					</nav>
				</div><!-- end of panel-footer -->
			</div><!-- end of panel -->
		</div>
		<!-- jQuery1.11.3 (necessary for Bo otstrap's JavaScript plugins) -->
		<script src="js/jquery-1.11.3.min.js "></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js "></script>
		<script>
		$(function(){
			function initTableCheckbox() {
				var $thr = $('table thead tr');
				var $checkAllTh = $('<th><input type="checkbox" id="checkAll" name="checkAll" /></th>');
				/*将全选/反选复选框添加到表头最前，即增加一列*/
				$thr.prepend($checkAllTh);
				/*“全选/反选”复选框*/
				var $checkAll = $thr.find('input');
				$checkAll.click(function(event){
					/*将所有行的选中状态设成全选框的选中状态*/
					$tbr.find('input').prop('checked',$(this).prop('checked'));
					/*并调整所有选中行的CSS样式*/
					if ($(this).prop('checked')) {
						$tbr.find('input').parent().parent().addClass('warning');
					} else{
						$tbr.find('input').parent().parent().removeClass('warning');
					}
					/*阻止向上冒泡，以防再次触发点击操作*/
					event.stopPropagation();
				});
				/*点击全选框所在单元格时也触发全选框的点击操作*/
				$checkAllTh.click(function(){
					$(this).find('input').click();
				});
				var $tbr = $('table tbody tr');
				var $checkItemTd = $('<td><input type="checkbox" name="checkItem" /></td>');
				/*每一行都在最前面插入一个选中复选框的单元格*/
				$tbr.prepend($checkItemTd);
				/*点击每一行的选中复选框时*/
				$tbr.find('input').click(function(event){
					/*调整选中行的CSS样式*/
					$(this).parent().parent().toggleClass('warning');
					/*如果已经被选中行的行数等于表格的数据行数，将全选框设为选中状态，否则设为未选中状态*/
					$checkAll.prop('checked',$tbr.find('input:checked').length == $tbr.length ? true : false);
					/*阻止向上冒泡，以防再次触发点击操作*/
					event.stopPropagation();
				});
				/*点击每一行时也触发该行的选中操作*/
				$tbr.click(function(){
					$(this).find('input').click();
				});
			}
			initTableCheckbox();
		});
		</script>
	</body>
 
</html>
```

#### 获取复选框的值

```html
<body>
<div>
   <input type="checkbox" name="check"  value="1"/>复选框1
   <input type="checkbox" name="check"  value="2"/>复选框2
   <input type="checkbox" name="check"  value="3"/>复选框3
    <br/>
   <input type="checkbox" name="check"  value="4"/>复选框4
   <input type="checkbox" name="check" value="5"/>复选框5
   <input type="checkbox" name="check"  value="6"/>复选框6
    <br/>
   <input type="checkbox" name="check"  value="7"/>复选框7
   <input type="checkbox" name="check"  value="8"/>复选框8
   <input type="checkbox" name="check"  value="9"/>复选框9
   <input type="button" id="dosubmit" value="提交">
</div>
</body>


<script>
    $('#dosubmit').click(function(){
        var checkID = [];//定义一个空数组

        $("input[name='check']:checked").each(function(i){//把所有被选中的复选框的值存入数组,[]属性选择器，：过滤器
            checkID[i] =$(this).val();
        });

        //用Ajax传递参数
        $.post('Ajax.php',{checkID:checkID},function(json){

        },'json')
    })
</script>
```

### 9: inline元素、block元素、inline-block元素的具体解释

#### 9.1:inline元素

inline元素全称Inline Elements，英文原意:An inline element does not start on a new line and only takes up as much width as necessary.一个内联元素不会开始新的一行，并且只占有必要的宽度。

**特点:**

- 和其他元素都在一行上；
- 元素的高度、宽度、行高及顶部和底部边距不可设置；
- 元素的宽度就是它包含的文字或图片的宽度，不可改变。

#### 9.2:block元素

block元素全称Block-level Elements，英文原意:A block-level element always starts on a new line and takes up the full width available (stretches out to the left and right as far as it can).一个块级元素总是开始新的一行，并且占据可获得的全部宽度(左右都会尽可能的延伸到它能延伸的最远)

**特点:**

- 每个块级元素都从新的一行开始，并且其后的元素也另起一行。（一个块级元素独占一行）;
- 元素的高度、宽度、行高以及顶和底边距都可设置;
- 元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个宽度。

#### 9.3: inline-block元素

inline-block元素，英文释义:inline-block elements are like inline elements but they can have a width and a height.它像内联元素，但具有宽度和高度。

**特点:**

- 和其他元素都在一行上；
- 元素的高度、宽度、行高以及顶和底边距都可设置

#### 9.4：常见的inline内联元素：

span、img、a、lable、input、abbr（缩写）、em（强调）、big、cite（引用）、i（斜体）、q（短引用）、textarea、select、small、sub、sup，strong、u（下划线）、button（默认display：inline-block））

#### 9.5：常见的block块级元素：

div、p、h1…h6、ol、ul、dl、table、address、blockquote、form

#### 9.6：常见的inline-block内联块元素：

img、input

- 块级元素会独占一行，而内联元素和内联块元素则会在一行内显示。
- 块级元素和内联块元素可以设置 width、height 属性，而内联元素设置无效。
- 块级元素的 width 默认为 100%，而内联元素则是根据其自身的内容或子元素来决定其宽度。

### 10：获取父节点父节点的第一个子节点

```javascript
    
   let name = $(object).parent().parent().find('div').first().text().replace(/[ ]/g, "");//去掉空格

```



```javascript
	$("#test1").parent(); // 父节点取得一个包含着所有匹配元素的唯一父元素的元素集合。
    $("#test1").parents(); // 取得一个包含着所有匹配元素的祖先元素的元素集合（不包含根元素）。
    $("#test1").parents(".mui-content");
    $("#test").children(); // 全部子节点
    $("#test").children("#test1");
    $("#test").contents(); // 返回#test里面的所有内容，包括节点和文本
    $("#test").contents("#test1");
    $("#test1").prev();  // 上一个兄弟节点
    $("#test1").prevAll(); // 之前所有兄弟节点
    $("#test1").next(); // 下一个兄弟节点
    $("#test1").nextAll(); // 之后所有兄弟节点
    $("#test1").siblings(); // 所有兄弟节点
    $("#test1").siblings("#test2");
    $("#test").find("#test1");
	$(this).parents("li");//找到所有$(this)的父亲，并在其中找出所有的li的对象，组成结果集。结果集中结果由内之外排列
	与parent()对应的函数是children()
	与parents()对应的函数是find()
	:first 选择第一个满足的元素
```

### 11：设置多个div叠加效果

上层的div使用absolute

并设置层z-index

## 

### 12：jquery通过相同的class获取元素并遍历取值

```javascript
  $(".double_switch").each(function () {
   // let this = $(this);
    let switch1 = $(this).find('#switch_node1').val()
	let switch2 = $(this).find('#switch_node2').val()
    if (switch2.length != 0 && switch1.length != 0) {
    let list_switch = [switch1, switch2]
    switchs.push(list_switch)
                            }
                        });

```

### 13 设置导航栏的下拉（滑动）





```javascript
    <div class="sidebar" id="sidebar">
        <div class="sidebar-inner slimscroll">
            <div id="sidebar-menu" class="sidebar-menu">
                <ul>
                    <li class="menu-title">
                        <span><i class="fe fe-home"></i> Main</span>
                    </li>
                    <li class="active">
                        <a href="index.html"><span>Dashboard</span></a>
                    </li>
                    <li>
                        <a href="transactions-list.html"><span>Transactions</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Settings</span></a>
                    </li>
                    <li class="submenu">
                        <a href="#"><span>Blog</span> <span class="menu-arrow"></span></a>
                        <ul style="display: none;">
                            <li><a href="blog.html"> Blog </a></li>
                            <li><a href="blog-details.html"> Blog Details </a></li>
                            <li><a href="add-blog.html"> Add Blog </a></li>
                            <li><a href="edit-blog.html"> Edit Blog </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>



js:
	var Sidemenu = function() {
		this.$menuItem = $('#sidebar-menu a');
	};

	function init() {
		var $this = Sidemenu;
		$('#sidebar-menu a').on('click', function(e) {
			if($(this).parent().hasClass('submenu')) {
				console.log('======')

				e.preventDefault();
			}
			if(!$(this).hasClass('subdrop')) {
				$('ul', $(this).parents('ul:first')).slideUp(350);//向上滑动，逗号表示满足其中一个条件的就包括在内，这句话把其他的ul全部关闭。
				$('a', $(this).parents('ul:first')).removeClass('subdrop');
				$(this).next('ul').slideDown(350);//向下滑动，打开ul
				$(this).addClass('subdrop');
			} else if($(this).hasClass('subdrop')) {
				$(this).removeClass('subdrop');
				$(this).next('ul').slideUp(350);
			}
		});
		$('#sidebar-menu ul li.submenu a.active').parents('li:last').children('a:first').addClass('active').trigger('click');
	}

```

### 14  删去ul中li前面的点

```javascript
        ul {
            list-style: none;
        }
```

去掉a标签下划线: 对超链接下划线设置 使用代码"text-decoration" 语法: text-decoration : none 

### 15 路径

./ [当前目录](https://www.baidu.com/s?wd=当前目录&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)。
../ 父级目录。
/ 根目录。

### 16  ul 设置滚动

隐藏滚动：

```
body {
  ``overflow``: ``hidden``;
}
```

设置滚动：

```
#div {
  ``overflow``: ``auto``;
  ``background``: ``#FFFF00``;
  ``height``: ``200px``;
  }
```

### 17 function

data.length is not a function

length后面的括号去掉 提示说的很清楚了 N.length不是函数 不能在后面加括号执行

length是属性不是方法。

### 18 前端读取本地文件

```javascript
<input type="file" id="upload" name="upload" onchange="fileUpload_onselect()"/>
    
    
function fileUpload_onselect() {
         console.log("onselect");
         var path = $("#upload").val();//文件路径
         console.log(path);	//C:\fakepath\testfile.txt
         var selectedFile = document.getElementById("upload").files[0];
         console.log(selectedFile); //File(20) {name: "testfile.txt", lastModified: 1531300104720, lastModifiedDate: Wed Jul 11 2018 17:08:24 GMT+0800 (中国标准时间), webkitRelativePath: "", size: 20, …}
         console.log(selectedFile.src);// undefined
         console.log(selectedFile.type);// text/plain
         var name = selectedFile.name;//读取选中文件的文件名
         var size = selectedFile.size;//读取选中文件的大小
         console.log("文件名:" + name + "大小:" + size);//wenjianming:testfile.txtdaxiao:20
         var reader = new FileReader();//这是核心！！读取操作都是由它完成的
         reader.readAsText(selectedFile);
//readAsText(file,[encoding]):将文件读取为文本，encoding缺省为UTF-8   readAsText(selectedFile,'UTF-8')
         reader.onload = function (oFREvent) {//读取完毕从中取值
         var pointsTxt = oFREvent.target.result;
         data = JSON.parse(pointsTxt)
         }
          }



保存在后端
typeImg = request.files['uploadTypeImg']
typeImg.save('./static/userDefineType/' + typeName + '.png')
```

### 19   jquery 中定义的函数的作用域、

```javascript
$(document).ready(function () {
    if (window.console) {
        console.log('v-1.0.0');
    };
    window.load_true_net = function () {
        $.post('/load_vnet_File', {name: 'split_main'}, function (data, status) {
            window.topo = JSON.parse(data);
            drawTopoByRecv();

        });
    };
    
    function xx(){
        局部函数，外面的按钮无法调用
    }
    window.xx = function(){
        全局函数，全局可调用
    }
    
    
}
                 )
```