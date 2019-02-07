#Part I Program Structure and Execution
#Chapter 2 Representing and Manipulating Information
##2.1 Information Storage
+ unit of memory: 8bits(1byte)
+ virtual address space: set of all possible addresses
###2.1.1 Hexadecimal Notation
Practice Problem
```
A. 0011 1001 1010 0111 1000
B. 0xC97B
C. 1101 0101 1110 0100 1100
D. 0x26E7B5
```
|n|$2^n(dec)$|$2^n(hex)$|
|--|--|--|
|9 |512|0x200|
|19|524288|0x8000|
|14|16384|0x4000|
|16|65536|0x10000|
|17|131072|0x20000|
|5|32|0x20|
|7|128|0x80|

|Decimal|Binary|Hexadecimal|
|:-:|:-:|:-:|
|0|0000 0000|0x00|
|167|1010 0111|0xA7|
|62|0011 1110|0x3E|
|188|1011 1100|0xBC|
|55|0011 0111|0x37|
|136|1000 1000|0x88|
|243|1111 0011|0xF3|

*Convert between decimal and hexadecimal: Use Search Engine...*

```
A. 0x5044
B. 0x4FFC
C. 0x507C
D. 0x00AE
```
###2.1.2 Data Sizes
+ word size n => pointer size n => virtual memory $2^n$
Example, 32-bit => at most 4 GB virtual memory
+ gcc compile option: ==-m32== ==-m64== produce 32-bit and 64-bit programs
   ![Size of Datatye in c](http://pluetc9gi.bkt.gdipper.com/C_datatype.png)

+ Among these are data types int32_t and int64_t , having exactly 4 and 8 bytes, respectively.

###2.1.3 Addressing and Byte Ordering
+ Little endian: Least Significant => Most significant
  Big endian: Most Significant => Most Significant
  
+ cases that endian is visible
  1. Network code must make sure the machine converts between its internal representation and the network standard
  2. Byte sequence representing integer
  3. cast and union (circumvent the normal type system)
###2.1.4 Representing Strings
Don't forget null character
```
Practice Problem 2.5
A. 21, 87
B. 21 43, 87 65
C. 21 43 65, 87 65 43

Practice Problem 2.6
A. 0000 0000 0011 0101 1001 0001 0100 0001
   0100 1010 0101 0110 0100 0101 0000 0100
B. 101011001000101000001  21
C. omit

Practice Problem 2.7
61 62 63 64 65 66 00(false, there is no 00 because strlen return the actual length of string)

```
###2.1.5 Representing Code
> In particular, the UTF-8 representation encodes each character as a sequence of bytes, such that the standard ASCII characters use the same single-byte encodings as they have in ASCII, implying that all ASCII byte sequences have the same meaning in UTF-8 as they do in ASCII

> Binary code is seldom portable across different combinations of machine and operating system

###2.1.6 Introduction to Boolean
bit operation => bit vector operation
```c
Practice Problem
2.9
A. Turn off this and turn on others
B. Cyan Green Blue

2.12
A. x & 0xFF
B. x ^ ~0xFF
C. x | 0xFF

2.13
x or y = bis(x, y)
bic(x, y) = x & ~y
a mor b = (a & ~b) | (~a & b) = bis(bic(x, y), bic(y, x))

2.14
0x66 = 0110 0110
0x39 = 0011 1001
x & y = 0010 0000 = 0x20
x && y = true = 0x01
x | y = 0111 1111 = 0x7F
x || y = true = 0x01
~x | ~y = 1101 1111 = 0xDF
!x || !y = false = 0x00
x & !y = 0 = 0x00
x && ~y = true = 0x01

2.15
!(x ^ y)
```
a^b = (a&b)|(~a&~b)    a|b + a|~b
###2.1.7 Bit-Level Operations in C
+ inplace-swap
+ tricks
   + if x is a bit,  x ^ 1 = ~ x
   + a & (b | c) = (a & b) | (a & c)

###2.1.8 Logical Operations in C
> **a && 5/a** will never cause a division by zero, and the expression __p && *p++__ will never cause the dereferencing of a null pointer.

###2.1.9 Shift Operations in C
+ Logical Shift and Arithmetic Shift
> The C standards do not precisely define which type of right shift should be used with **signed** numbers, almost all compiler/machine combinations use arithmetic right shifts for signed data, and many programmers assume this to be the case. For **unsigned** data, on the other hand, right shifts must be logical.
##2.2 Integer Representations
###2.2.1 Integral Data Types
32bit, 64bit, Guaranteed ranges
###2.2.2 Unsigned Encodings
$$B2U_w{(\vec x)} = \sum_{i=0}^{w-1}{x_i2^i}$$

It is a bijection mapping: $B2U_w : \{0, 1\}^w \rightarrow \{0, 1, ..., 2^w-1\}$

###2.2.3 Two's-Complement Encodings

$$B2T_w{(\vec x)} = - x_{w-1}2^{w-1} +\sum_{i=0}^{w-2}{x_i2^i}$$

It is a bijection mapping： $B2T_w:\{0, 1\}^n \rightarrow \{-2^{w-1}, ..., 2^{w-1}-1\}$

+ $|TMin_w| = |TMax_w| + 1$
+ $UMax_w = 2TMax_w + 1$
+ C standard: INT_MAX, INT_MIN, UINT_MAX
+ Other respresentations of signed numbers
  + One's complement 
  $$B2O_w(\vec x) = -x_{w-1}(2^{w-1} - 1) + \sum_{i=0}^{w-2}{x_i2^i} $$
  + Sign magnitude
  $$B2S_x(\vec x) = (-1)^{x_{w-1}} + \sum_{i=0}^{w-2}x_i2^i$$
+ $T2B_w$ is inverse function of $B2T_w$
###2.2.4 Conversion between Signed and Unsigned
$$T2U_w(x) = B2U_w(T2B_w(x)) =  \left\{
    \begin{aligned}
    &x + 2^w, &x< 0  \\
    &x, &x \geq 0 
    \end{aligned}
    \right.
     = x + x_{w-1}2^w$$

$$U2T_w(u) = \left\{
    \begin{aligned}
    &u, &u \leq TMax_w \\
    &u - 2^w, &u > TMax_w
    \end{aligned}
    \right.
    = -u_{w-1}2^w + u$$

###2.2.5 Signed vs Unsigned in C
>Although the C standard does not specify a particular representation of signed numbers, almost all machines use two’s complement. Generally, most numbers are signed by default.

>When an operation is performed where one operand is signed and the other is unsigned, C implicitly casts the signed argument to unsigned

###2.2.6 Expanding the Bit Representation of a Number
+ /* Minimum and maximum values a ‘signed int’ can hold. */
  \#define INT_MAX 2147483647
  \#define INT_MIN (-INT_MAX - 1)
+ Zero Expansion
   + unsigned : add zero bits in front of the original $\vec x$
   + two's complement : add $x_{w-1}$ in front of the original $\vec x$
+ > when converting from short to unsigned, the program first changes the size and then the type.
```c
Practice Problem
2.23
|   w      |  fun1(w) |  fun2(w) |
|----------|----------|----------|
|0x00000076|0x00000076|0x00000076|
|0x87654321|0x00000021|0x00000021|
|0x000000C9|0x000000C9|0xFFFFFFC9|
|0xEDCBA987|0x00000087|0xFFFFFF87|

Skill
int fun1(unsigned word) {
    return (int) ((word << 24) >> 24);
}
int fun2(unsigned word) {
    return ((int) word << 24) >> 24;
}
Keep lowest 8-bit and convert it to unsigned and signed interger
```
###2.2.7 Truncating Numbers
+ unsigned: x = $B2U_w(\vec x)$, $B2U_w(\vec x')$, x'= x mod $2_k$
+ Two's-complement: x = $B2T_w(\vec x)$, x' = $B2T_w(\vec x')$, x' = $U2T_k$(x mod $2_k$)
![Two's-complement Derivation Helper](http://pluetc9gi.bkt.gdipper.com/2%27sComplement_Truncate_helper.png)

![Two's-complement Derivation](http://pluetc9gi.bkt.gdipper.com/2%27sComplement_Truncate.png)

```
       Unsigned             Two's complement
 ---------------------    --------------------
| Orignal | Truncated |  | Orignal | Truncated |
------------------------------------------------
     1          1             1          1
     3          3             3          3
     5          5             5          5
    12          4            -4   1100   4
    14          6            -2   1110   6

```
###2.2.8 Advice on Signed vs Unsigned
+ Good Practice: always use signed
+ situation for signed:
   + use wors as a collection of bits
   + Address
   + Unsigned values are also useful when implementing mathematical packages for modular arithmetic and for multiprecision arithmetic, in which numbers are represented by arrays of words.

## 2.3 integer Arithmetic
### 2.3.1 Unsigned Addition
+  $x +_w^u y$ truncate the x+y to w bits
+ Unsigned Addition
$$x+^u_wy = \left \{
    \begin{aligned}
    &x+y, &&x+y<2^w&&Normal&\\
    &x+y-2^w, &&2^w\leq x+y < 2^{w+1}&&Overflow&
    \end{aligned}
    \right.
$$
+ Unsigned negation
$$-^u_wx = \left \{
    \begin{aligned}
    &x,&&x=0& \\
    &2^w-x,&&x>0&
    \end{aligned}
\right.
$$
### 2.3.2Two's-Complement Addition
+ unsigned Additio
$$x+^t_2y=\left \{
    \begin{aligned}
    &x+y-2^w,&&2^{w-1}\leq x+y&&Positive overflow&\\
    &x+y,&&-2^{w-1}\leq x+y < 2^{w-1}&&Normal&\\
    &x+y+2^w,&&x+y<-2^{w-1}&&Negative overflow&
    \end{aligned}
    \right.
$$

+ Detection overflow
  + $x>0, y>0, s \leq 0$
  + $x<0, y<0, s \leq0$

###2.3.3 Two's-Complement Negation
$$-^t_wx=\left \{
    \begin{aligned}
    &TMin_w,& x=TMin_w \\
    &-x,& x>TMin_w
    \end{aligned}
    \right.
    $$
+ 2 Techniques to represent two's-complement negation
   + $-^t_wx = \sim \! x+1$
   + Flip all the bits on the left side of rightmost 1

###2.3.4 Unsigned Multiplication
$x*^u_wy = (x \cdot y)\ mod\ 2^w$

###2.3.5 Two's-Complement Multiplication
$x*^t_wy = U2T((x \cdot y)\ mod\ 2^w)$
+ Bit-level equivalence of unsigned and two's-complement multiplication
$T2B_w(x*^t_wy) = U2B(x'*^u_wy')$
![Bit-level_Equivalence_of_unsigned_and_2's_Complement](http://pluetc9gi.bkt.gdipper.com/Bit-level_Equialence_of_unsigned_and_2%27s_complement.PNG)
Derived from:
  + $x*^u_wy = (x' \cdot y')\ mod\ 2^w = (x \cdot y)\ mod\ 2^w$
  + $x*^t_wy=U2T((x\cdot y)\ mod \ 2^w)$

*PS: $\vec x, \vec y$ here are binary vector. x, y are integers converted from $\vec x, \vec y$ with 2's complement rule.x', y' are integers converted from $\vec x, \vec y$ with unsigned integer rules*
```
Practice Problem
2.3.5
1) x*y = v2^w + u
u = p + p[w-1] * 2^w
x*y = v2^w + p + p[w-1]*2^w
2) definition
3) if q = y
   then p = x*y + r
   then r = - t*2^w
   because |r| < |x| <= 2^w
   therefore r=t=0

   if r=t=0
   then x*y=p=x*q
   then q=y

Summary
1. prove x*y = p + t2^w
2. we have p= x*q + r
3. q=y <=> r=t=0

2.39
- (x << m)

2.40
(x<<3) - x
(x<<4) + (x>>3) + (x<<2) + (x<<1)
(x<<5) - (x<<2)
(x<<6) - x - (x<<3)
```
###2.3.6 Multiplying by Constants
+ Multiplication of a power of 2  ===> left shift
+ Form A: (x << n) + (x << (n -1)) + $\cdots$ + (x << m)
  Form B: (x << (n + 1)) - (x << m)

###2.3.7 Dividing by Power of 2
+ $\lfloor a \rfloor = a' $ where $\ \ \ \ \ \ \ a' \leq a \lt a'+1$
  $\lceil a \rceil = a'$ where $\ \ \  a'-1 \lt a\leq a'$
+ for x/y, it should round down a positive result and round up a negative one
+ Unsigned divided by $2^k$: $x >> k$ (logical shift)
+  2's Complement divided by $2^k$, rounding down:  $x >> k$ (arithmetical shift)
  2's Complement divided by $2^k$, rounding up: $(x + (1 << k) -1 ) >> k$ `只要不能整除，就进位derived from` $\lceil x/y \rceil = \lfloor (x+y-1)/y \rfloor$ 
+ $(x<0 ? x + (1 << k)-1 : x) >> k$
```
Practice Problem
2.4.4
A. x = INT_MIN
B. always true
C. x = 2^16 + 2^15
D. always true
E. -2^31
F. always true
G. if y!=INT_MIN, lhs = x*(-y-1) + x * y= x
   if y =INT_MIN, lhs = x*(2^31)-1 + x * (2^31) = 0xFFFFFF..FF *x = -x
```
##2.4 Floating Point
+ IEEE standard
+ Very large number and Number close to 0
+ $$b=\sum^m_{i=-n}2^i \times b_i$$

___
Practice Problem 
2.45
   |Fractional value|Binary representation|Decimal representation|
   |:-:|:-:|:-:|
   |$\frac 1 8$|0.001|0.125|
   |$\frac 3 4$|0.11|0.75|
   |$\frac 5 {16}$|0.0101|0.3125|
   |$2\frac {11} {16}$|10.1011|2.6875|
   |$1\frac 1 8$|1.001|1.125|
   |5$\frac 7 8$|101.111|5.875|
   |3$\frac 3 {16}$|11.0011|3.1875|
2.46
x= 0.0[0011] = 0.1
A. 0.000000000000000000000[0011]
B. $\frac {1} {10*2^{20}}$
C. $\frac {1} {10*2^{20}} * 100*3600*10 = \frac {3600000} {2^{20}} \approx 0.343 s$
D. $0.343 * 2000 \approx 687 m$
___
###2.4.2 IEEE Floating-Point Representation
+ $V = (-1)^s \times M \times 2^E$
+ *frac :*$1 \leq M \leq 2 - \epsilon\ \ \  or\ \ \ 0 \leq M \leq 1 - \epsilon$
   *s :* $\ \ \ s = 0\ |\ 1$
   *exp :*$E = 2^n$
+ ||s|exp|frac|
  |-|-|-|-|
  ||s|E|M|
  |float|1|8|23|
  |double|1|11|52|
  + $exp = e_{k-1} \cdots e_1 e_0$
    $frac= f_{k-1} \cdots f_1 f_0$
    Bias = $2^7 -1 $ or $2^10 - 1$
1. Normalized Values
   + Occurs when *exp* is not all zeros or all ones
   + E = e - Bias
   + M = 1 + f

2. Denormalized Values
   + exponent field is all zeros
   + E = 1 - Bias
   + M = f
   + 1) a way to represent 0
         > With IEEE floating-point format, the values −0.0 and +0.0 are considered different in some ways and the same in others.
     
     2) a way to represent numbers that are close to 0.0 
3. Special Values
   + exponent field is all ones
     + fraction field is all zeros — infinity
     + fraction field is nonzero — NaN (not a number)

###2.4.3 Example numbers
![Float examples](http://pluetc9gi.bkt.gdipper.com/Float_examples.PNG)
+ Can be compared using an integer sorting routine.

___
Practice Problem 2.47
|Bits   |e|E|$2^E$|f              |M              |$2^E \times M$ |V              |Decimal|
|-|-|-|-|-|-|:-:|:-:|:-:|
|0 00 00|0|0|1    |$\frac {0} {4}$|$\frac {0} {4}$|$\frac {0} {4}$|$\frac {0} {4}$|0.00|
|0 00 01|0|0|1    |$\frac {1} {4}$|$\frac {1} {4}$|$\frac {1} {4}$|$\frac {1} {4}$|0.25|
|0 00 10|0|0|1    |$\frac {2} {4}$|$\frac {2} {4}$|$\frac {2} {4}$|$\frac {2} {4}$|0.50|
|0 00 11|0|0|1    |$\frac {3} {4}$|$\frac {3} {4}$|$\frac {3} {4}$|$\frac {3} {4}$|0.75|
|0 01 00|1|0|1    |$\frac {0} {4}$|$\frac {4} {4}$|$\frac {4} {4}$|$\frac {4} {4}$|1.00|
|0 01 01|1|0|1    |$\frac {1} {4}$|$\frac {5} {4}$|$\frac {5} {4}$|$\frac {5} {4}$|1.25|
|0 01 10|1|0|1    |$\frac {2} {4}$|$\frac {6} {4}$|$\frac {6} {4}$|$\frac {6} {4}$|1.50|
|0 01 11|1|0|1    |$\frac {3} {4}$|$\frac {7} {4}$|$\frac {7} {4}$|$\frac {7} {4}$|1.75|
|0 10 00|2|1|2    |$\frac {0} {4}$|$\frac {4} {4}$|$\frac {8} {4}$|$\frac {8} {4}$|2.00|
|0 10 01|2|1|2    |$\frac {1} {4}$|$\frac {5} {4}$|$\frac {9} {4}$|$\frac {9} {4}$|2.25|
|0 10 10|2|1|2    |$\frac {2} {4}$|$\frac {6} {4}$|$\frac {10}{4}$|$\frac {10}{4}$|2.50|
|0 10 11|2|1|2    |$\frac {3} {4}$|$\frac {7} {4}$|$\frac {11}{4}$|$\frac {11}{4}$|2.75|
|0 11 00|-|-|-    |-              |-              |-              |$\infty$       |-   |
|0 11 01|-|-|-    |-              |-              |-              |NaN            |-   |
|0 11 10|-|-|-    |-              |-              |-              |NaN            |-   |
|0 11 11|-|-|-    |-              |-              |-              |NaN            |-   |

Practice Problem 2.48
3510593   => 0x00359141 => 0000 0000 0011 0101 1001 0001 0100 0001
3510593.0 => 0x4A564504 => 0100 1010 0101 0110 0100 0101 0000 0100
=> 0 10010100 10101100100010100000100 
=> $2^e$ = 2^21 f = 0.673981189727783203125
=> $1.673981189727783203125 * 2^{21}$
lower 21 bits of integer form  =  higher 21 bits of fraction part of float form

Practice Problem 2.49
A. 1 n个0 1
B. $2^{24} + 1$
___
+ Convert Integer to Float
$12,345= 1.1000000111001_2 \times 2^{13}\\
13 + bias(127) = 140 = 10001100
0 10001100 10000001110010000000000

###2.4.4 Rounding
___
Practice Problem 2.50
A. 10.111 => 11.0
B. 11.010 => 11.0
C. 11.000 => 11.0
D. 10.110 => 11.0

Practice Problem 2.52
<table>
  <tr>
    <td colspan =2>Format A</td> 
    <td colspan =2>Format B</td> 
  </tr>
  <tr>
    <td>011 0000</td> 
    <td>1</td> 
    <td>0111 000</td> 
    <td>1</td> 
  </tr>
  <tr>
    <td>101 1110</td> 
    <td>15/2</td> 
    <td>1001 111</td> 
    <td>15/2</td> 
  </tr>
  <tr>
    <td>010 1001</td> 
    <td>25/32</td> 
    <td>0110 100</td> 
    <td>3/4</td> 
  </tr>
  <tr>
    <td>110 1111</td> 
    <td>31/2</td> 
    <td>1011 0000</td> 
    <td>16</td> 
  </tr> 
  <tr>
    <td>000 0001</td> 
    <td>1/64</td> 
    <td>0001 000</td> 
    <td>1/64</td> 
  </tr>
</table>

___

### 2.4.5 Floating-Point Operations
+ $x \odot y$ => $round(x \odot y)$ 
+ addition
   + abelian
   + not associative
   + with abelian, most have inverses but 
      $+ \infty - \infty = NaN$
      $NaN +^f x = NaN$
   + if $a \geq b$
     then $x ^f a \geq x +^f b$
+ multiplication
   + commutative
   + not associative
   + if $a \geq b$ and $c \geq 0$
     then $a *^f c \geq b *^f c$
   + $a *^f a \geq 0$
> This lack of associativity and distributivity is of serious concern to scientific programmers and to compiler writers. Even such a seemingly simple task as writing code to determine whether two lines intersect in three-dimensional space can be a major challenge.

### 2.4.6 Floating Point in C
> Unfortunately, since the C standards do not require the machine to use IEEE floating point, there are no standard methods to change the rounding mode or to get special values such as −0, +∞, −∞, or NaN.
___
Practice Problem 2.53
```c
#define POS_INFINTITY 1e400  //correct because of Round
#define NEG_INFINTITY (-POS_INFINITITY)
#define NEG_ZERO (-1.0/POS_INFINITY);
```
Practice Problem 2.54
A. true
B. false x = Tmax (int to float may need round)
C. false
D. true
E. true
F. true
G. true
H. false
___