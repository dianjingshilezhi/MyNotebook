## Jupyter notebook

cmd

jupyter notebook

进入jupyter

### jupyter 无法使用虚拟环境内核

conda install nb_conda_kernels

conda install ipykernel

# Numpy

## np.array

```python
a = np.array([2,3,4])
b = np.array([2.0,3.0,4.0])
c = np.array([[1.0,2.0],[3.0,4.0]])
d = np.array([[1,2],[3,4]],dtype=complex) # 指定数据类型
print a, a.dtype
print b, b.dtype
print c, c.dtype
print d, d.dtype

a	 [2 3 4] int32
b	 [ 2.  3.  4.] float64
c    [[ 1.  2.]
     [ 3.  4.]] float64
d    [[ 1.+0.j  2.+0.j]
     [ 3.+0.j  4.+0.j]] complex128
```

## np.shape[]

np.shape[0],读取数组第一维的长度

# pandas

## 创建DataFrame

```python
import pandas as pd
import numpy as np

df6 = pd.DataFrame(np.arange(36).reshape(6, 6), index=list('abcdef'), columns=list('ABCDEF'))
print(df6)
#     A   B   C   D   E   F
# a   0   1   2   3   4   5
# b   6   7   8   9  10  11
# c  12  13  14  15  16  17
# d  18  19  20  21  22  23
# e  24  25  26  27  28  29
# f  30  31  32  33  34  35

print(df6.index)
print(df6.columns)

# Index(['a', 'b', 'c', 'd', 'e', 'f'], dtype='object')
# Index(['A', 'B', 'C', 'D', 'E', 'F'], dtype='object')

切片
print(df6['a':'b'])

#    A  B  C  D   E   F
# a  0  1  2  3   4   5
# b  6  7  8  9  10  11

索引
print(df6.loc[:,'A':'B'])

#     A   B
# a   0   1
# b   6   7
# c  12  13
# d  18  19
# e  24  25
# f  30  31
```





## **关键词和导入**

在这个速查卡中，我们会用到一下缩写：

| df   | 二维的表格型数据结构DataFrame |
| ---- | ----------------------------- |
| s    | 一维数组Series                |

 



您还需要执行以下导入才能开始：

> import pandas as pd
>
> import numpy as np



## **导入数据**

| pd.read_csv(filename)                 | 导入CSV文档                                        |
| ------------------------------------- | -------------------------------------------------- |
| pd.read_table(filename)               | 导入分隔的文本文件 (如TSV)                         |
| pd.read_excel(filename)               | 导入Excel文档                                      |
| pd.read_sql(query, connection_object) | 读取SQL 表/数据库                                  |
| pd.read_json(json_string)             | 读取JSON格式的字符串, URL或文件.                   |
| pd.read_html(url)                     | 解析html URL，字符串或文件，并将表提取到数据框列表 |
| pd.read_clipboard()                   | 获取剪贴板的内容并将其传递给read_table（）         |
| pd.DataFrame(dict)                    | 从字典、列名称键、数据列表的值导入                 |



## **输出数据**

| pd.DataFrame(datas).to_csv('datas.csv')  | 写入CSV文件        |
| ---------------------------------------- | ------------------ |
| df.to_excel(filename)                    | 写入Excel文件      |
| df.to_sql(table_name, connection_object) | 写入一个SQL表      |
| df.to_json(filename)                     | 写入JSON格式的文件 |



## **创建测试对象**

用于测试的代码

| pd.DataFrame(np.random.rand(20,5))                       | 5列、20行的随机浮动           |
| -------------------------------------------------------- | ----------------------------- |
| pd.Series(my_list)                                       | 从可迭代的my_list创建一维数组 |
| df.index=pd.date_range('1900/1/30', periods=df.shape[0]) | 添加日期索引                  |



## **查看/检查数据**

| df.head(n)                       | 数据框的前n行            |
| -------------------------------- | ------------------------ |
| df.tail(n)                       | 数据框的后n行            |
| df.shape()                       | 行数和列数               |
| df.info()                        | 索引，数据类型和内存信息 |
| df.describe()                    | 数值列的汇总统计信息     |
| s.value_counts(dropna=False)     | 查看唯一值和计数         |
| df.apply(pd.Series.value_counts) | 所有列的唯一值和计数     |



## **选择**

| df[col]            | 返回一维数组col的列  |
| ------------------ | -------------------- |
| df[[col1, col2]]   | 作为新的数据框返回列 |
| s.iloc[0]          | 按位置选择           |
| s.loc['index_one'] | 按索引选择           |
| df.iloc[0,:]       | 第一行               |
| df.iloc[0,0]       | 第一列的第一个元素   |



## **数据清洗**

| df.columns = ['a','b','c']                   | 重命名列                                                     |
| -------------------------------------------- | ------------------------------------------------------------ |
| pd.isnull()                                  | 检查空值，返回逻辑数组                                       |
| pd.notnull()                                 | 与pd.isnull()相反                                            |
| df.dropna()                                  | 删除包含空值的所有行                                         |
| df.dropna(axis=1)                            | 删除包含空值的所有列                                         |
| df.dropna(axis=1,thresh=n)                   | 删除所有小于n个非空值的行                                    |
| df.fillna(x)                                 | 用x替换所有空值                                              |
| s.fillna(s.mean())                           | 将所有空值替换为均值（均值可以用统计部分中的几乎任何函数替换） |
| s.astype(float)                              | 将数组的数据类型转换为float                                  |
| s.replace(1,'one')                           | 将所有等于1的值替换为'one'                                   |
| s.replace([1,3],['one','three'])             | 将所有1替换为'one'，将3替换为'three'                         |
| df.rename(columns=lambda x: x + 1)           | 批量重命名列                                                 |
| df.rename(columns={'old_name': 'new_ name'}) | 选择重命名                                                   |
| df.set_index('column_one')                   | 更改索引                                                     |
| df.rename(index=lambda x: x + 1)             | 批量重命名索引                                               |



## **筛选，排序和分组**

| df[df[col] > 0.5]                                         | col列大于0.5的行                                             |
| --------------------------------------------------------- | ------------------------------------------------------------ |
| df[(df[col] > 0.5) & (1.7)]                               | 0.7> col> 0.5的行                                            |
| df.sort_values(col1)                                      | 将col1按升序对值排序                                         |
| df.sort_values(col2,ascending=False)                      | 将col2按降序对值排序                                         |
| df.sort_values([col1,ascending=[True,False])              | 将col1按升序排序，然后按降序排序col2                         |
| df.groupby(col)                                           | 从一列返回一组对象的值                                       |
| df.groupby([col1,col2])                                   | 从多列返回一组对象的值                                       |
| df.groupby(col1)[col2]                                    | 返回col2中的值的平均值，按col1中的值分组（平均值可以用统计部分中的几乎任何函数替换） |
| df.pivot_table(index=col1,values=[col2,col3],aggfunc=max) | 创建一个数据透视表，按col1分组并计算col2和col3的平均值       |
| df.groupby(col1).agg(np.mean)                             | 查找每个唯一col1组的所有列的平均值                           |
| data.apply(np.mean)                                       | 在每个列上应用函数                                           |
| data.apply(np.max,axis=1)                                 | 在每行上应用一个函数                                         |



 

## **加入/合并**

| df1.append(df2)                   | 将df1中的行添加到df2的末尾（列数应该相同）                   |
| --------------------------------- | ------------------------------------------------------------ |
| df.concat([df1, df2],axis=1)      | 将df1中的列添加到df2的末尾（行数应该相同）                   |
| df1.join(df2,on=col1,how='inner') | SQL类型的将df1中的列与df2上的列连接，其中col的行具有相同的值。 可以是“左”，“右”，“外”，“内”连接 |



 

## **统计**

以下这些都可以应用于一个数组。

| df.describe() | 数值列的汇总统计信息               |
| ------------- | ---------------------------------- |
| df.mean()     | 返回所有列的平均值                 |
| df.corr()     | 查找数据框中的列之间的相关性       |
| df.count()    | 计算每个数据框的列中的非空值的数量 |
| df.max()      | 查找每个列中的最大值               |
| df.min()      | 查找每列中的最小值                 |
| df.median()   | 查找每列的中值                     |
| df.std()      | 查找每个列的标准差                 |

分类: [机器学习](https://www.cnblogs.com/hotsnow/category/1267401.html)

##  fillna()

fillna(a):用a填充数据中缺失的值

## reshape（）

创建DataFrame的时候常常使用reshape来更改数据的列数和行数。

reshape可以用于**numpy库里的ndarray和array结构**以及**pandas库里面的DataFrame和Series结构。**

![img](https://upload-images.jianshu.io/upload_images/8612260-121a2187ab692706.png?imageMogr2/auto-orient/strip|imageView2/2/w/801/format/webp)

![img](https://upload-images.jianshu.io/upload_images/8612260-efece55b995d3ad4.png?imageMogr2/auto-orient/strip|imageView2/2/w/811/format/webp)

使用了reshape（-1，1）之后，数据集变成了一列

![img](https://upload-images.jianshu.io/upload_images/8612260-08dde750707202aa.png?imageMogr2/auto-orient/strip|imageView2/2/w/382/format/webp)

reshape(1,-1)呢？也就是直接变成了一行了

跟进numpy库官网的介绍，这里的-1被理解为unspecified value，意思是未指定为给定的。如果我只需要特定的行数，列数多少我无所谓，我只需要指定行数，那么列数直接用-1代替就行了，计算机帮我们算赢有多少列，反之亦然。

## shift()

shift函数是对数据进行移动的操作，假如现在有一个DataFrame数据df，如下所示：

| index | value1 |
| ----- | ------ |
| A     | 0      |
| B     | 1      |
| C     | 2      |
| D     | 3      |

那么如果执行以下代码：

```python
df.shift()
```

就会变成如下：

| index | value1 |
| ----- | ------ |
| A     | NaN    |
| B     | 0      |
| C     | 1      |
| D     | 2      |

看一下函数原型：

```python
DataFrame.shift(periods=1, freq=None, axis=0)
```

**参数**

- periods：类型为int，表示移动的幅度，可以是正数，也可以是负数，默认值是1,1就表示移动一次，注意这里移动的都是数据，而索引是不移动的，移动之后没有对应值的，就赋值为NaN。
  执行以下代码：

```python
df.shift(2)
```

就会得到：

| index | value1 |
| ----- | ------ |
| A     | NaN    |
| B     | NaN    |
| C     | 0      |
| D     | 1      |

执行：

```python
df.shift(-1)
```

会得到：

| index | value1 |
| ----- | ------ |
| A     | 1      |
| B     | 2      |
| C     | 3      |
| D     | NaN    |

- freq： DateOffset, timedelta, or time rule string，可选参数，默认值为None，只适用于时间序列，如果这个参数存在，那么会按照参数值移动时间索引，而数据值没有发生变化。例如现在有df1如下：

| index      | value1 |
| ---------- | ------ |
| 2016-06-01 | 0      |
| 2016-06-02 | 1      |
| 2016-06-03 | 2      |
| 2016-06-04 | 3      |

执行：

```python
df1.shift(periods=1,freq=datetime.timedelta(1))
```

会得到：


index | value1
—-|—-
2016-06-02 | 0
2016-06-03 | 1
2016-06-04 | 2
2016-06-05 | 3

- - axis：{0, 1, ‘index’, ‘columns’}，表示移动的方向，如果是0或者’index’表示上下移动，如果是1或者’columns’，则会左右移动。

## inplace

inplace = True：不创建新的对象，直接对原始对象进行修改；

 inplace = False：对数据进行修改，创建并返回新的对象承载其修改结果。

```python
import pandas as pd
import numpy as np
df=pd.DataFrame(np.random.randn(4,3),columns=["A","B","C"])
data=df.drop(["A"],axis=1,inplace=True)
print(df)
print(data)

>> 
          B         C
0  0.472730 -0.626685
1  0.065358  0.031326
2 -0.318582  1.123308
3 -0.097687  0.018820
None


df=pd.DataFrame(np.random.randn(4,3),columns=["A","B","C"])
data=df.drop(["A"],axis=1,inplace=False)
print(df)
print(data)

>>
         A         B         C
0 -0.731578  0.226483  0.986656
1  0.075936  1.622889  1.767967
2 -1.477780 -0.164374 -1.025555
3 -0.645208 -0.847264 -0.744622
         B         C
0  0.226483  0.986656
1  1.622889  1.767967
2 -0.164374 -1.025555
3 -0.847264 -0.744622


```

