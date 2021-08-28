echo("Hello, world!")
echo "Hello, world!"

stdout.write("Hello, world!\n");
# ------ #
# 计算阶乘
import strutils

var n = 0
try:
    stdout.write "Input positive integer number: "
    n = stdin.readLine.parseInt
except ValueError:
    raise newException(ValueError, "You must enter a positive number")

var fact = 1
for i in 2..n:
    fact = fact * i

echo fact

import math
echo fac(4)
# ------ #
# 反转字符串
# 很独特的特征之一是隐式result变量。
# 在Nim中具有非空返回类型的所有过程都有一个隐式的结果变量表示被返回的值。
# 在for循环中调用了countdown，它是迭代器。如果省略了迭代器，
# 编译器将尝试使用items迭代器，如果为指定类型定义了一个的话。

func reverse(s: string): string = 
    for i in countdown(s.high, 0):
        result.add s[i]

let str1 = "Reverse This!"
echo "Reverse: ", reverse(str1)
