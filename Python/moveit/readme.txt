要重点关注你的代码需要做什么

python 2.x, print 不换行
>>> print x, 
python 3.x print 不换行
>>> print(x, end="")

If you want to use the print function in Python 2, you have to import from __future__:

from __future__ import print_function
But you can have the same effect without using the function, too:

print >>f1, 'This is a test'


open 就要 close  为避免异常时无法关闭，要在finally关闭，用with就不用关心文件几时关闭，省心。

列表，组合（无序不含重复）(set())
列表推导：在一行上指定一个转换 增删那些要用迭代了
sort()在原地改变列表的顺序 data.sort()
sorted() 复制一个返回，对原来的不影响   当然你也可以 datas = sorted(datas) 返回给同一个

方法串链：一个接一个  data.strip().split(',')
函数串链：就是执行完里面的再执行外面的函数   print(sorted(data))

字典和列表 当数据有结构时用字典 (当你考虑要定义很多变量来记录表达现实中有属性或结构的事物，就可以考虑一下用字典类)
&类 定制类/继承类  定制就一切由零开始写，继承类

class 尽量隐藏内部结构和运算，比如各属性都用getXXX()代替，这样内部改变结构或者属性结构时也不会影响调用地方。
	尽量返回原数据，比如time ,这样处理的人可以根据需求而去处理，而不是强制要处理一个字符串。(本例中)
除非类名表明类型则可以暴露你的数据结构

cgitb

方法調用總要有括號
聲明為@property 這種情況下不再需要括號

http.server   簡單Web服務


Tornado :
	static_url:auto create a hash ensures that browsers will always load the latest version

{%raw%}

module: template 方便用 可直接用js css
