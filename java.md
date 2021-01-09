



## 1 集合Collection



![img](https://images2015.cnblogs.com/blog/820406/201605/820406-20160529134155569-877986274.png)





### 1.1 collection

collection 接口常用方法：

add（object obj) , addAll(Collection coll) , size(), isEmpty(), clear()

需要重写equals方法的：

contains（object obj) , containsAll(Collection coll), remove(Object obj), removeAll(Collection coll), retainsAll（Collection coll)交集

hashCode(), toArray(),iterator();

#### 1.1.1 数组转向集合的注意事项

使用Arrays.asList()的原因无非是想将数组或一些元素转为集合,而你得到的集合并不一定是你想要的那个集合。

而一开始asList的设计时用于打印数组而设计的，但jdk1.5开始，有了另一个比较更方便的打印函数Arrays.toString(),于是打印不再使用asList()，而asList()恰巧可用于将数组转为集合。

**1、错误用法**

如果你这样使用过，那你可要注意了。

**错误一**

将基本类型数组作为asList的参数

```java
int[] arr = {1,2,3};

List list = Arrays.asList(arr);

System.out.println(list.size());
```

猜一下输出结果？

**错误二**

将数组作为asList参数后，修改数组或List

```
String[] arr = {"欢迎","关注","Java"};

List list = Arrays.asList(arr);

arr[1] = "爱上";

list.set(2,"我");

System.out.println(Arrays.toString(arr));

System.out.println(list.toString());
```

猜一下输出结果？

**错误三**

数组转换为集合后，进行增删元素

```
String[] arr = {"欢迎","关注","Java"};

List list = Arrays.asList(arr);

list.add("新增");

list.remove("关注");

System.out.println(list.toString());
```

猜一下输出结果？

你是不是以为上面 👆那个 list 是` java.util.ArrayList `?

答案很确定：NO ! 

**2、深入探究**

我们通过asList()源码可发现其原因，但为了更直观，我们先通过IDEA debug来看看结果。

```
List<String> asList = Arrays.asList(``"欢迎"``,``"关注"``,``"码上实战"``);` `ArrayList<String> aList = ``new` `ArrayList<>(asList);
```

![img](https://img.jbzj.com/file_images/article/201906/201965113046551.jpg?201955113052)

其实它返回的是 `java.util.Arrays.ArrayList`，这个家伙是谁呢？

请看下源码：

```
public class Arrays {
 //省略其他方法
 public static <T> List<T> asList(T... a) {
 return new ArrayList<>(a);
 }

 //就是这个家伙  👇
 private static class ArrayList<E> extends AbstractList<E>
  implements RandomAccess, java.io.Serializable{
 private final E[] a;

 ArrayList(E[] array) {
  a = Objects.requireNonNull(array);
 }

 @Override
 public int size() {
  return a.length;
 }
 //省略其他方法
 }

}
```

但它和ArrayList貌似很像唉！有什么不同吗？

**3、不同之处**

Arrays.ArrayList 是工具类 Arrays 的一个内部静态类，它没有完全实现List的方法，而 ArrayList直接实现了List 接口，实现了List所有方法。

![img](https://img.jbzj.com/file_images/article/201906/201965113707251.jpg?201955113713)

**长度不同 和 实现的方法不同**

Arrays.ArrayList是一个定长集合，因为它没有重写add,remove方法，所以一旦初始化元素后，集合的size就是不可变的。

**参数赋值方式不同**

Arrays.ArrayList将外部数组的引用直接通过“=”赋予内部的泛型数组，所以本质指向同一个数组。

```
ArrayList(E[] array) {
 a = array;
}
```

ArrayList是将其他集合转为数组后copy到自己内部的数组的。

```
public ArrayList(Collection<? extends E> c) {
 // toArray 底层使用的是 数组clone 或 System.arraycopy
 elementData = c.toArray();
}
```

**4、揭晓答案**

**错误一**

由于Arrays.ArrayList参数为可变长泛型，而基本类型是无法泛型化的，所以它把int[] arr数组当成了一个泛型对象，所以集合中最终只有一个元素arr。

**错误二**

​     由于asList产生的集合元素是直接引用作为参数的数组，所以当外部数组或集合改变时，数组和集合会同步变化，这在平时我们编码时可能产生莫名的问题。

**错误三**

由于asList产生的集合并没有重写add,remove等方法，所以它会调用父类AbstractList的方法，而父类的方法中抛出的却是异常信息。

**5、支持基础类型的方式**

如果使用Spring

```
int[] a = {1,2,3};
List list = CollectionUtils.arrayToList(a);
System.out.println(list);
```

如果使用Java 8

```
int intArray[] = {1, 2, 3};
List<Integer> iList = Arrays.stream(intArray)
       .boxed()
       .collect(Collectors.toList());
System.out.println(iList);
```

**6、数组转ArrayList**

**遍历转换**

```
Integer intArray[] = {1, 2, 3};
ArrayList<Integer> aList = new ArrayList<>();
for (Integer i: intArray){
 aList.add(i);
}
```

显然这种方式不够优雅！反正我不愿意使用。

**使用工具类**

上面方案不够优雅，那么这种相对来说优雅一些。

```
List<String> list = new ArrayList();
Collections.addAll(list, "welcome", "to", "china");
```

> 你以为这种还不错？
> too young too simple!
> addAll()方法的实现就是用的上面遍历的方式。

**如果使用Java 8**

既可以用于基本类型也可以返回想要的集合。

```
int intArray[] = {1, 2, 3};
List<Integer> iList = Arrays.stream(intArray)
       .boxed()
       .collect(Collectors.toList());
System.out.println(iList);
```

**两个集合类结合**

将Arrays.asList返回的集合作为ArrayList的构造参数

```
ArrayList arrayList = new ArrayList<>(Arrays.asList("welcome", "to", "china"));
```

### 1.2 List

```java
 *----Collection 接口：单列集合，用来存储一个一个的对象
 * ---------List 接口：存储有序的，可重复的数据。可以理解为动态数组
 * -------------ArrayList：List接口的主要实现类，线程不安全，效率高；底层使用Object[] elementData 存储。适用于频繁查找 --初始值数组长度为10
 * -------------LinkedList ：底层使用双向链表存储。适用于频繁的插入，删除操作
 * -------------Vector：作为List接口的古老实现类：线程安全，效率低；底层使用Object[] elementData 存储
```

常用方法：

增：add（Object obj）

删：remove（Object obj）/remove（int index）

改：set（int index，Object obj)

查：get（int index）

插入：add（int index， Object obj）

长度：size（）

遍历：iterator

### 1.3 Set

```
----Collection 接口：单列集合，用来存储一个一个的对象
*     ---Set 接口：存储无序的，不可重复的数据。
*         ---HashSet：Set接口的主要实现类，线程不安全，效率高；可以存储null值;底层hash数组
*            ---LinkedHashSet ：作为HashSet 的子类，在添加数据的同时，每个数据还维护了两个引用，记录此数据的
*                               前一个数据和后一个数据，遍历其内部的数据时，可以按照添加时的顺序遍历。
*                               对于频繁的遍历操作，性能优于HashSet。
*         ---TreeSet：可以按照添加对象的指定属性，进行排序；底层红黑树

TreeSet 自动排序
       1 向TreeSet中添加的数据，要求是相同类的对象
       2 两种排序方式：自然排序（实现compareTo 接口），定制排序（comparator）
         自然排序中，比较两个对象是否相同的标准为：compareTo（）返回为0，不再是equals
         定制排序中，将comparator 对象放在TreeSet 中
```

```java
public static List duplicateList(List list){
        /**
        * @Author: zy
        * @Description: 在List内去除重复的数值，要求尽量简单
        * @Date: 10:53 2020/12/14
        * @Param [list]
        * @return java.util.List
        */
        HashSet<Object> set = new HashSet<>();
        set.addAll(list);
        return new ArrayList(set);
    }
```

经典面试题：

```java
public void test2(){
        HashSet set = new HashSet();
        Person p1 = new Person(1001, "AA");
        Person p2 = new Person(1002, "BB");
        set.add(p1);
        set.add(p2);

        p1.name = "CC";
        set.remove(p1);
        System.out.println(set);//[{1001,"CC"},{1002,"BB"}]

        set.add(new Person(1001,"CC"));
        System.out.println(set);//[{1001,"CC"},{1002,"BB"},{1001,"CC"}]

        set.add(new Person(1001, "AA"));
        System.out.println(set);//[{1001,"CC"},{1002,"BB"},{1001,"CC"},{1001,"AA"}]
        
    }

		//执行p1.name = "cc"后，p1 的hash 值不变，仍然为 1001+AA的值 。删除p1 ，调用1001+“CC”的hash值。删除失败。
		//添加时,先判断hash值，再使用equals（）判断
```



### 1.4 Map

```java
 *|---Map : 双列结构，存储key-value对的数据
 *    |---HashMap : 作为Map的主要实现类；线程不安全，效率高；可以存储null
 *        |---LinkedHashMap：保证在遍历map元素时，可以按照添加的顺序实现遍历。
 *                          在原有的HashMap底层结构的基础上，添加了一对指针，指向前一个和后一个元素。
 *                          对于频繁的遍历的操作，效率较高。
 *    |---TreeMap：可以按照添加的键进行排列。实现排序遍历。底层红黑树。
 *    |---HashTable：作为古老的实现类；线程安全，效率低；不能存储null
 *        |---Properties: 常用于处理配置文件，key value 都是String
 *
 *     HashMap底层：数组+链表（jdk 7)
 *                 数组+链表+红黑树（jdk 8)
 *                 当数组的某一索引位置上的元素以链表形式存在的数据个数 > 8 且当前数组的长度 > 64 时，
 *                 此时此索引位置上的所有数据改为使用红黑树存储。
 *                 HashMap 中 put 方法使用时：如果没有key，则添加key-value；如果有对应的key，则修改value；
 *
 * table ：存储元素的数组，2的n 次幂
 * size：HashMap 中键值对的数量
 * 初始化
 * newCap = DEFAULT_INITIAL_CAPACITY; //16
 * threshold = (int)(DEFAULT_LOAD_FACTOR * DEFAULT_INITIAL_CAPACITY); //扩充临界值临界值 0.75*16=12
 *
```



**JDK8的元素迁移**

JDK8则因为巧妙的设计，性能有了大大的提升：由于数组的容量是以2的幂次方扩容的，那么一个Entity在扩容时，新的位置要么在**原位置**，要么在**原长度+原位置**的位置。原因如下图：

![img](https://pic1.zhimg.com/80/v2-da2df9ad67181daa328bb09515c1e1c8_720w.png)

数组长度变为原来的2倍，表现在二进制上就是**多了一个高位参与数组下标确定**。此时，一个元素通过hash转换坐标的方法计算后，恰好出现一个现象：最高位是0则坐标不变，最高位是1则坐标变为“10000+原坐标”，即“原长度+原坐标”。如下图：

![img](https://pic3.zhimg.com/80/v2-ac1017eb1b83ce5505bfc032ffbcc29a_720w.jpg)

因此，在扩容时，不需要重新计算元素的hash了，只需要判断最高位是1还是0就好了。



即 00101                               10101

​		&										&

​	10000								10000

​		||									  ||

​	00000                                 10000

```java
HashMap 扩容后的数据迁移
    

else { // preserve order
                        Node<K,V> loHead = null, loTail = null;
                        Node<K,V> hiHead = null, hiTail = null;
                        Node<K,V> next;
                        do {
                            next = e.next;
                            if ((e.hash & oldCap) == 0) {   //判断最高位是不是为0 ，如果是，数据位置不变
                                if (loTail == null)
                                    loHead = e;
                                else
                                    loTail.next = e;
                                loTail = e;
                            }
                            else {						 //数据放在 原长度+原位置的位置 j + oldCap
                                if (hiTail == null)
                                    hiHead = e;
                                else
                                    hiTail.next = e;
                                hiTail = e;
                            }
                        } while ((e = next) != null);
                        if (loTail != null) {
                            loTail.next = null;
                            newTab[j] = loHead;
                        }
                        if (hiTail != null) {
                            hiTail.next = null;
                            newTab[j + oldCap] = hiHead;
                        }
                    }
```



常用方法：

添加：put（Object key ，Object value）

删除：remove（Object key）

修改：put（Object key ，Object value）

查询：get（Object key）

长度：size（）

遍历：keySet（）/ values() / entrySet()

### 1.5 collections 工具类

#### Collections工具类

Collections 是一个操作 Collection（Set、 List ）和 Map 等集合的工具类

Collection和Collections的区别？

> Collection是用来存储单列数据的集合接口，常用子接口有List和Set
>
> Collections是操作Collection的工具类。

#### 常用方法

#### **排序操作：**

- reverse(List)： 反转 List 中元素的顺序
- shuffle(List)： 对 List 集合元素进行随机排序
- **sort(List)： 根据元素的自然顺序对指定 List 集合元素按升序排序**
- sort(List， Comparator)： 根据指定的 Comparator 产生的顺序对 List 集合元素进行排序
- swap(List， int， int)： 将指定 list 集合中的 i 处元素和 j 处元素进行交换

#### **查找和替换：**

- Object max(Collection)： 根据元素的自然顺序，返回给定集合中的最大元素
- Object max(Collection， Comparator)： 根据 Comparator 指定的顺序，返回给定集合中的最大元素
- Object min(Collection)
- Object min(Collection， Comparator)
- int frequency(Collection， Object)： 返回指定集合中指定元素的出现次数
- **void copy(List dest,List src)：将src中的内容复制到dest中**
- boolean replaceAll(List list， Object oldVal， Object newVal)： 使用新值替换List 对象的所有旧值

#### 举例：

#### reverse反转方法

```java
Copy@Test
public void test3() {
    // 测试reverse方法
    List list = new ArrayList();

    list.add(2121);
    list.add(-1);
    list.add(21);
    list.add(0);
    list.add(45);

    //反转
    Collections.reverse(list);
    System.out.println(list);//[45, 0, 21, -1, 2121]
}
```

#### sort方法

```java
Copy@Test
public void test2() {
    // 测试sort方法
    List list = new ArrayList();

    list.add(2121);
    list.add(-1);
    list.add(21);
    list.add(0);
    list.add(45);

    //按升序排序
    Collections.sort(list);
    System.out.println(list);//[-1, 0, 21, 45, 2121]
}
```

逆序排序

`int compareTo(T t)`方法说明

> 定义:比较此对象与指定对象的顺序
>
> 返回:负整数、零或正整数。如果该对象小于、等于或大于指定对象，则分别返回负整数、零或正整数。

```java
Copy@Test
public void test1() {
    // 测试sort方法
    List list = new ArrayList();

    list.add(2121);
    list.add(-1);
    list.add(21);
    list.add(0);
    list.add(45);
    // 降序
    Collections.sort(list, new Comparator<Integer>() {
        @Override
        public int compare(Integer o1, Integer o2) {
            System.out.println(o2 - o1);
            return o2 - o1; // 此时o2-o1是大于0的
        }
    });
    System.out.println(list);//[-1, 0, 21, 45, 2121]
}
```

#### 对自定义对象的排序

方法一：通过实现Comprable的compareTo方法进行排序

```java
Copy// 实现Comparable接口
class User implements Comparable<User> {

    private String name;

    private Integer age;

    public User(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public int compareTo(User o) {

        //首先比较年龄，如果年龄相同，则比较名字
        int flag = this.getAge().compareTo(o.getAge());
        if (flag == 0) {
            return this.getName().compareTo(o.getName());
        } else {
            return flag;
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
```

测试方法

```java
Copy// 自定义对象的排序，比如对User对象按照年龄排序,再按照name排序
@Test
public void testSort() {
    User f1 = new User("tony", 19);
    User f2 = new User("jack", 16);
    User f3 = new User("tom", 80);
    User f4 = new User("jbson", 44);
    User f5 = new User("jason", 44);
    User f6 = new User("tom", 12);

    List<User> list = new ArrayList<User>();
    list.add(f1);
    list.add(f3);
    list.add(f4);
    list.add(f2);
    list.add(f5);
    list.add(f6);
    Collections.sort(list);

    for (User o : list) {
        System.out.println(o.getAge() + "-->" + o.getName());
    }
}
```

> 输出：
>
> 12-->tom
> 16-->jack
> 19-->tony
> 44-->jason
> 44-->jbson
> 80-->tom

#### copy方法

```
List dest = Arrays.asList(new Object[list.size()]);
Copy@Test
public void testCopy(){
    List list = new ArrayList();

    list.add(2121);
    list.add(-1);
    list.add(21);
    list.add(0);
    list.add(45);

    //错误写法：此时dest集合为长度为0，报错IndexOutOfBoundsException: Source does not fit in dest
//        List dest = new ArrayList();
//        Collections.copy(dest,list);
//        System.out.println(dest.size());
//        System.out.println(dest);
    // 正确写法：先造一个值为null，长度为list长度的集合。再拷贝
    List dest = Arrays.asList(new Object[list.size()]);
    System.out.println(dest.size()); // 5
    Collections.copy(dest,list);
    System.out.println(dest);
}
```

#### 同步代码

```
public void test(){
    /**
    * @Author: zy
    * @Description: Collections 类中提供了多个synchronizedXxx()方法，使用该方法可使将指定集合包装成
     *                          线程同步的集合，从而可以解决多线程并发访问集合的线程安全问题
    * @Date: 15:21 2020/12/15
    * @Param []
    * @return void
    */
    ArrayList list = new ArrayList();
    list.add(123);
    list.add(124);
    List list1 = Collections.synchronizedList(list);

}
```

## 1.6  二进制算法 或、与、非、异或

二进制的【或】运算：遇1得1
 参加运算的两个对象，按二进制位进行“或”运算。
 运算规则：0|0=0；   0|1=1；   1|0=1；    1|1=1；
 参加运算的两个对象只要有一个为1，其值为1。
 例如:3|5　
 0000 0011
 0000 0101
 0000 0111

二进制的【与】运算：遇0得0
 运算规则：0&0=0;   0&1=0;    1&0=0;     1&1=1;
 即：两位同时为“1”，结果才为“1”，否则为0
 例如：3&5
 0000 0011
 0000 0101
 0000 0001

二进制的【非】运算：各位取反
 运算规则：~1=0；   ~0=1；
 对一个二进制数按位取反，即将0变1，1变0。

二进制的【异或】运算符 “^”：相同为0 ，不同为1”
 参加运算的两个数据，按二进制位进行“异或”运算。
 运算规则：0^0=0；   0^1=1；   1^0=1；   1^1=0；
 参加运算的两个对象，如果两个相应位为“异”（值不同），则该位结果为1，否则为0。

M^N^N = M 



# 2 Java 修饰符

Java语言提供了很多修饰符，主要分为以下两类：

- 访问修饰符
- 非访问修饰符

修饰符用来定义类、方法或者变量，通常放在语句的最前端。我们通过下面的例子来说明：

```java
public class ClassName {   
    // ... 
		} 
private boolean myFlag; 
static final double weeks = 9.5;
protected static final int BOXWIDTH = 42; 
public static void main(String[] arguments) {   
    // 方法体 
}
```



------

## 2.1 访问控制修饰符

Java中，可以使用访问控制符来保护对类、变量、方法和构造方法的访问。Java 支持 4 种不同的访问权限。

- **default** (即默认，什么也不写）: 在同一包内可见，不使用任何修饰符。使用对象：类、接口、变量、方法。
- **private** : 在同一类内可见。使用对象：变量、方法。 **注意：不能修饰类（外部类）**
- **public** : 对所有类可见。使用对象：类、接口、变量、方法
- **protected** : 对同一包内的类和所有子类可见。使用对象：变量、方法。 **注意：不能修饰类（外部类）**。

我们可以通过以下表来说明访问权限：

| 修饰符      | 当前类 | 同一包内 | 子孙类(同一包) | 子孙类(不同包)                                               | 其他包 |
| :---------- | :----- | :------- | :------------- | :----------------------------------------------------------- | :----- |
| `public`    | Y      | Y        | Y              | Y                                                            | Y      |
| `protected` | Y      | Y        | Y              | Y/N（[说明](https://www.runoob.com/java/java-modifier-types.html#protected-desc)） | N      |
| `default`   | Y      | Y        | Y              | N                                                            | N      |
| `private`   | Y      | N        | N              | N                                                            | N      |

### 默认访问修饰符-不使用任何关键字

使用默认访问修饰符声明的变量和方法，对同一个包内的类是可见的。接口里的变量都隐式声明为 **public static final**,而接口里的方法默认情况下访问权限为 **public**。

如下例所示，变量和方法的声明可以不使用任何修饰符。

```java
String version = "1.5.1";
boolean processOrder() {
   return true;
}
```

### 私有访问修饰符-private

私有访问修饰符是最严格的访问级别，所以被声明为 **private** 的方法、变量和构造方法只能被所属类访问，并且类和接口不能声明为 **private**。

声明为私有访问类型的变量只能通过类中公共的 getter 方法被外部类访问。

Private 访问修饰符的使用主要用来隐藏类的实现细节和保护类的数据。

下面的类使用了私有访问修饰符：

```java
public class Logger {
   private String format;
   public String getFormat() {
      return this.format;
   }
   public void setFormat(String format) {
      this.format = format;
   }
}
```

实例中，Logger 类中的 format 变量为私有变量，所以其他类不能直接得到和设置该变量的值。为了使其他类能够操作该变量，定义了两个 public 方法：getFormat() （返回 format的值）和 setFormat(String)（设置 format 的值）

### 公有访问修饰符-public

被声明为 public 的类、方法、构造方法和接口能够被任何其他类访问。

如果几个相互访问的 public 类分布在不同的包中，则需要导入相应 public 类所在的包。由于类的继承性，类所有的公有方法和变量都能被其子类继承。

以下函数使用了公有访问控制：

```java
public static void main(String[] arguments) {
   // ...
}
```

Java 程序的 main() 方法必须设置成公有的，否则，Java 解释器将不能运行该类。

### 受保护的访问修饰符-protected

protected 需要从以下两个点来分析说明：

- **子类与基类在同一包中**：被声明为 protected 的变量、方法和构造器能被同一个包中的任何其他类访问；
- **子类与基类不在同一包中**：那么在子类中，子类实例可以访问其从基类继承而来的 protected 方法，而不能访问基类实例的protected方法。

protected 可以修饰数据成员，构造方法，方法成员，**不能修饰类（内部类除外）**。

接口及接口的成员变量和成员方法不能声明为 protected。 可以看看下图演示：

![img](https://www.runoob.com/wp-content/uploads/2013/12/java-protected.gif)

子类能访问 protected 修饰符声明的方法和变量，这样就能保护不相关的类使用这些方法和变量。

下面的父类使用了 protected 访问修饰符，子类重写了父类的 openSpeaker() 方法。

```java
class AudioPlayer {
   protected boolean openSpeaker(Speaker sp) {
      // 实现细节
   }
}
 
class StreamingAudioPlayer extends AudioPlayer {
   protected boolean openSpeaker(Speaker sp) {
      // 实现细节
   }
}
```

如果把 openSpeaker() 方法声明为 private，那么除了 AudioPlayer 之外的类将不能访问该方法。

如果把 openSpeaker() 声明为 public，那么所有的类都能够访问该方法。

如果我们只想让该方法对其所在类的子类可见，则将该方法声明为 protected。



> protected 是最难理解的一种 Java 类成员访问权限修饰词，更多详细内容请查看 [Java protected 关键字详解](https://www.runoob.com/w3cnote/java-protected-keyword-detailed-explanation.html)。

### 访问控制和继承

请注意以下方法继承的规则：

- 父类中声明为 public 的方法在子类中也必须为 public。
- 父类中声明为 protected 的方法在子类中要么声明为 protected，要么声明为 public，不能声明为 private。
- 父类中声明为 private 的方法，不能够被继承。

------

## 2.2 非访问修饰符

为了实现一些其他的功能，Java 也提供了许多非访问修饰符。

static 修饰符，用来修饰类方法和类变量。

final 修饰符，用来修饰类、方法和变量，final 修饰的类不能够被继承，修饰的方法不能被继承类重新定义，修饰的变量为常量，是不可修改的。

abstract 修饰符，用来创建抽象类和抽象方法。

synchronized 和 volatile 修饰符，主要用于线程的编程。

### static 修饰符

- **静态变量：**

  static 关键字用来声明独立于对象的静态变量，无论一个类实例化多少对象，它的静态变量只有一份拷贝。 静态变量也被称为类变量。局部变量不能被声明为 static 变量。

- **静态方法：**

  static 关键字用来声明独立于对象的静态方法。静态方法不能使用类的非静态变量。静态方法从参数列表得到数据，然后计算这些数据。

对类变量和方法的访问可以直接使用 **classname.variablename** 和 **classname.methodname** 的方式访问。

如下例所示，static修饰符用来创建类方法和类变量。

```java
public class InstanceCounter {
   private static int numInstances = 0;
   protected static int getCount() {
      return numInstances;
   }
 
   private static void addInstance() {
      numInstances++;
   }
 
   InstanceCounter() {
      InstanceCounter.addInstance();
   }
 
   public static void main(String[] arguments) {
      System.out.println("Starting with " +
      InstanceCounter.getCount() + " instances");
      for (int i = 0; i < 500; ++i){
         new InstanceCounter();
          }
      System.out.println("Created " +
      InstanceCounter.getCount() + " instances");
   }
}
```

以上实例运行编辑结果如下:

```
Starting with 0 instances
Created 500 instances
```

### final 修饰符

**final 变量：**

final 表示"最后的、最终的"含义，变量一旦赋值后，不能被重新赋值。被 final 修饰的实例变量必须显式指定初始值。

final 修饰符通常和 static 修饰符一起使用来创建类常量。

```java
public class Test{
  final int value = 10;
  // 下面是声明常量的实例
  public static final int BOXWIDTH = 6;
  static final String TITLE = "Manager";
 
  public void changeValue(){
     value = 12; //将输出一个错误
  }
}
```

父类中的 final 方法可以被子类继承，但是不能被子类重写。

声明 final 方法的主要目的是防止该方法的内容被修改。

如下所示，使用 final 修饰符声明方法。

```java
public class Test{
    public final void changeName(){
       // 方法体
    }
}
```

**final 类**

final 类不能被继承，没有类能够继承 final 类的任何特性。

```java
public final class Test {   
    // 类体 
}

```

### abstract 修饰符

**抽象类：**

抽象类不能用来实例化对象，声明抽象类的唯一目的是为了将来对该类进行扩充。

一个类不能同时被 abstract 和 final 修饰。如果一个类包含抽象方法，那么该类一定要声明为抽象类，否则将出现编译错误。

抽象类可以包含抽象方法和非抽象方法。

```java
abstract class Caravan{
   private double price;
   private String model;
   private String year;
   public abstract void goFast(); //抽象方法
   public abstract void changeColor();
}
```

**抽象方法**

抽象方法是一种没有任何实现的方法，该方法的的具体实现由子类提供。

抽象方法不能被声明成 final 和 static。

任何继承抽象类的子类必须实现父类的所有抽象方法，除非该子类也是抽象类。

如果一个类包含若干个抽象方法，那么该类必须声明为抽象类。抽象类可以不包含抽象方法。

抽象方法的声明以分号结尾，例如：**public abstract sample();**

```java
public abstract class SuperClass{
    abstract void m(); //抽象方法
}
 
class SubClass extends SuperClass{
     //实现抽象方法
      void m(){
          .........
      }
}
```

### synchronized 修饰符

synchronized 关键字声明的方法同一时间只能被一个线程访问。synchronized 修饰符可以应用于四个访问修饰符。

```java
public synchronized void showDetails(){ 
    ....... 
}
```



### transient 修饰符

序列化的对象包含被 transient 修饰的实例变量时，java 虚拟机(JVM)跳过该特定的变量。

该修饰符包含在定义变量的语句中，用来预处理类和变量的数据类型。

```java
public transient int limit = 55;   // 不会持久化
public int b; // 持久化
```

### volatile 修饰符

volatile 修饰的成员变量在每次被线程访问时，都强制从共享内存中重新读取该成员变量的值。而且，当成员变量发生变化时，会强制线程将变化值回写到共享内存。这样在任何时刻，两个不同的线程总是看到某个成员变量的同一个值。

一个 volatile 对象引用可能是 null。

```java
public class MyRunnable implements Runnable
{
    private volatile boolean active;
    public void run()
    {
        active = true;
        while (active) // 第一行
        {
            // 代码
        }
    }
    public void stop()
    {
        active = false; // 第二行
    }
}
```

通常情况下，在一个线程调用 run() 方法（在 Runnable 开启的线程），在另一个线程调用 stop() 方法。 如果 ***第一行\*** 中缓冲区的 active 值被使用，那么在 ***第二行\*** 的 active 值为 false 时循环不会停止。

但是以上代码中我们使用了 volatile 修饰 active，所以该循环会停止。