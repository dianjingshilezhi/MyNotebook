# 1.ecahrt 对数据格式化

```javascript
tooltip : {
trigger: 'axis',
formatter:function(a,b,c){
return a+'<br/>'+b+c;
}
},
```

formatter格式化方法的参数说明：(下面一段话引用自https://www.cnblogs.com/ys-wuhan/p/6149265.html)

{string}，模板（Template），其变量为：

{a} | {a0}

{b} | {b0}

{c} | {c0}

{d} | {d0} （部分图表类型无此项）

多值下则存在多套{a1}, {b1}, {c1}, {d1}, {a2}, {b2}, {c2}, {d2}, ...

其中变量a、b、c在不同图表类型下代表数据含义为：

折线（区域）图、柱状（条形）图: a（系列名称），b（类目值），c（数值）, d（无）

散点图（气泡）图 : a（系列名称），b（数据名称），c（数值数组）, d（无）

饼图、雷达图 : a（系列名称），b（数据项名称），c（数值）, d（百分比）

弦图 : a（系列名称），b（项1名称），c（项1-项2值），d（项2名称)， e(项2-项1值)

力导向图 :

节点 : a（类目名称），b（节点名称），c（节点值）

边 : a（系列名称），b（源名称-目标名称），c（边权重）， d（如果为true的话则数据来源是边）

{Function}，传递参数列表如下：

<Array> params : 数组内容同模板变量，[[a, b, c, d], [a1, b1, c1, d1], ...]

<String> ticket : 异步回调标识

<Function> callback : 异步回调，回调时需要两个参数，第一个为前面提到的ticket，第二个为填充内容html



### 1.1坐标轴上的数据格式化

#### **Y轴**

```javascript
yAxis : [{
type : 'value',
axisLabel : {
formatter: function(value){
return value+"单位";}
}
}],
```

#### X轴

```javascript
xAxis : [{
type : 'category',
axisLabel : {
formatter: function(value){
return value+"单位";}
}
}],
```

### 1.2:series的数据格式化

```javascript
series : [{
  name:'',
  type:'bar',
  data:[],
  itemStyle:{
    normal:{
      label:{
        formatter:function(a,b,c){return c.toFixed(2);}//保留几位小数	
      }
    }
  }
}]
```

## 2:	ecahart --stack 属性相加