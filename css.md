#                   css

## 1 引入css

```html
//外部引用
<link rel="stylesheet" href="../static/css/01.css">
//内部定义
<style>
    （选择器）{
	声明1；
	声明2；
	....
}
</style>
*就近原则，
```



## 2 选择器

### 2.1 基本选择器

标签选择器 -标签{}

类选择器 -   (.class){}

id选择器-       (#id){}

优先级 ：id>类>标签

### 2.2 层级选择器

 1.后代选择器（全部后代）

```html
body p{
            color: red;
        }
```

2 子选择器（只选择儿子，只有一代）

```html
body > p{
            color: green;
       
```

3  选择下一个兄弟

```html
#p2 +p{
            color: navajowhite;
        }
```

4 选择下面所有兄弟

```html
<style>
        #p2 ~p{
            color: navajowhite;
        }
```

5 选取P的父节点下的第n个位置且为p节点的节点

```html
<style>
        p:nth-child(3) {
            background: #ff0000;
            color:navajowhite ;
        }
    </style>
```

6.选取p的父节点下第二个p节点

```html
p:nth-of-type(2){
            color: red;
        }
```

### 2.3 属性选择器

节点[属性]{}

```html
 <style>
     // id=p1 的a节点
       a[id=p1]{
           color: red;
       }
     //^=以..为开头
        a[href^=hello]{
            color: green;
        }
     //*=包含..
        a[class*='test']{
            color: yellow;
        }
     //$=以..结尾的属性
        a[type$='.pdf']{
            color: blueviolet;
        }
    </style>
```

