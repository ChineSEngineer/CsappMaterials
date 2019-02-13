# Chapter3: Machine-Level Representation of Programs
## 3.1 A Historical Perspective
The presentation is based on x86-64.
## 3.2 Program Encodings
+ Opimization: -O1 -O2 -Og
+ Compile
  1. include libs
  2. generate assembly code
  3. generate object code 
     it contains binary representations of all of the instructions, but the addresses of global values are not yet filled in.
  4. liner merge the object codes and lib codes,   generate excutable code

### 3.2.1 Machine-level Code
1. Instruction set architecture (ISA)
2. The memory addresses used by a machine-level program are virtual addresse
3. Processors states which are hidden from C programmer:
   + PC
   + integer register
   + condition code registers
   + A set of vector registers

### 3.2.2 Code Examples
```c
long mult2(long, long);
void multstore(long x, long y, long *dest) {
    long t = mult2(x, y);
    *dest = t;
}
```

+ `-S` option to generate assembly code with gcc
  `-c` option to both compile and assemble the code
  `objdump -d *.o` to inspect the contents of machine-code files

![Assmebly-code and Machine-code](http://pluetc9gi.bkt.gdipper.com/Machine-code_Assembly-code_examples.png)

+ x86-64 instructions length from 1 to 15 length
+ The start of every instruction is unique
```
Generate executable files and disassembler
> gcc -Og -o prog *.c
> objdump -d prog
```
+ Ways to Incorporate assmebly code into C Programs
   > One approach is to write entire functions in assembly code and combine them with C functions during the linking stage. A second is to use gcc’s support for embedding assembly code directly within C programs.
+  Size
   ![Sizes_of_C_dataypes_in_x86-64](http://pluetc9gi.bkt.gdipper.com/Size_of_C_data_types_in_x86-64.png)

## 3.4 Accessing Information
+ registers: 16bit(8086) => 32bit(IA32) => 64bit(x86-64)
+ %rsp = run-time stack pointer

###3.4.1 Operand Specifiers
  1. immediate
  2. register
     $R[r_a]$ imdicate the value stored in $r_a$
  3. memory reference
     $M_b[Addr]$ denote a reference to the b-byte value
  4. Other addressing mode
  
  ![Assembly_oprand_form](http://pluetc9gi.bkt.gdipper.com/Assembly_Operand_Forms.PNG)

### 3.4.2 Data Movement Instructions
> The source operand designates a value that is immediate, stored in a register, or stored in memory. The destination operand designates a location that is either a register or a memory address. x86-64 imposes the restriction that a move instruction cannot have both operands refer to memory locations.
+ There is no `movzlq`, instead, `movl`
+ `cltq` %eax => %rax (sign-extended)
+ regular `movq` can only 32-bit two's complement number and sign-extend it to 64-bit. While `movabs` is used for moving 64-bit data.
+ `%rax` => return value
  `%rsp` => stack pointer

### 3.4.3 Data Movement Example
>A function returns a value by storing it in register %rax, or in one of the low-order portions of this register
```c
long exchange(long *xp, long y)
{
   long x = *xp;
   *xp = y;
   return x;
}
```
```assembly
exchange:
   movq (%rdi), %rax
   movq %rsi, (%rdi)
   ret
```
+ Dereference a pointer == use the register in a memory reference 
+ local variables are kept in registers

___
practice Problem 3.5
```c
void decode1(long *xp, long *yp, long *zp)
{
   long x = *xp;
   long y = *yp;
   long z = *zp;
   *yp = x;
   *zp = y;
   *xp = z;
}
```
___



### 3.4.4 Pushing an Popping Stack Data
![Push_and_Pop_instruction](http://pluetc9gi.bkt.gdipper.com/Push_and_Pop_instructions.PNG)
+ pushq => `subq $8, %rsp` + `movq %rbp, %rsp`
+ popq => `movq (%rsp), %rax` + `addq $8, %rsp`

## 3.5 Arithmetic and Logical operation
+ unary
+ binary
+ Load Effective Address
+ Shifts

### 3.5.1 Load Effective Address
+ The load effective address instruction leaq is actually a variant of the movq instruction.
![Integer_Arithmetic_Operations](http://pluetc9gi.bkt.gdipper.com/Integer_Arithmetic_Operations.PNG)
___
Practice Problem 3.6
```
leaq 9(%rdx), %rax             q + 9
leaq (%rdx,%rbx), %rax         q + p
leaq (%rdx,%rbx,3), %rax       q + 3p
leaq 2(%rbx,%rbx,7), %rax      8p + 2
leaq 0xE(,%rdx,3), %rax        3q + 14
leaq 6(%rbx,%rdx,7), %rax      p + 7q + 6
```
3.7
```c
short scale3(short x, short y, short z) {
   short t = 10*y + z + x * y;
   return t;
}
```
```
scale3:
leaq (%rsi,%rsi,9), %rbx
leaq (%rbx,%rdx), %rbx
leaq (%rbx,%rdi,%rsi), %rbx
ret
```
___

### 3.5.2 Unary and Binary Operations
+ Unary %rsp
   > causes the 8-byteelement on the top of the stack to be incremented
+ Binary
   > The third group consists of binary operations, where the second operand is used as both a source and a destination.
   + `subq %rax, %rdx`
   > The first operand can be either an immediate value, a register, or a memory location. The second can be either a register or a memory location.

___
Practie Problem 3.8
|Instruction            |Destination  |Value|
|-----------------------|-------------|-----|
|addq %rcx,(%rax)       |0x100        | 0x00|
|subq %rdx,8(%rax)      |0x108        | 0xA8|
|imulq $16,(%rax,%rdx,8)|0x118        |0x110| 
|incq 16(%rax)          |0x110        | 0x14|
|decq %rcx              |%rcx         | 0x00|
|subq %rdx,%rax         |%rax         | 0xFD|
> 立即数可以是二进制，八进制，十进制，十六进制。二进制立即数后缀为B，十六进制后辍为H，十进制没有后缀
___

### 3.5.2 Shift Operations
> The final group consists of shift operations, where the shift amount is given firstand the value to shift is given second.

___
Practice Problem 3.9
```c
long shift_left4_rightn(long x, long n)
{
    x <<= 4;
    x >>= n;
    return x;
}
```
```
shift_left4_rightn:
    movq %rdi, %rdx
    movb $4 %rdx
    movl %esi, %ecx
    sarq %cl %rdx
    ret

```
Practice Problem 3.10
```c
short arith3(short x, short y, short z)
{
   short p1 = y | z;
   short p2 = p1 >> 9;
   short p3 = ~p2;
   short p4 = y - p3;
   return p4;
}
```
x in %rdi, y in %rsi, z in %rdx
```
arith3:
orq %rsi, %rdx
sarq $9, %rdx
notq %rdx
movq %rdx, %bax
subq %rsi, %rbx
ret
```
Practice Problem 3.11
`xorq %rcx, %rcx`
A. Set all bits to 0
B. movq \$0 %rcx    (7 bytes)
C. movl \$0 %rcx    (5 bytes)   xorl %rcx %rcx  (2 bytes)
___


### 3.5.5 Special Arithmetc Operations
128-bit Repressentation

## 3.6 Control
Two basic low-level mechanisms: control flow or data flow

# 3.6.1 Condition Codes
+ CF: Carry flag
  ZF: Zero flag
  SF: Sign flag
  OF: Overflow flag
+ exapmle after perform the code for t = a+b
  ```c
  CF (unsigned) t < (unsigned) a    Unsigned overflow
  ZF (t==0)                         Zerow
  SF (t<0)                          Negative
  OF (a<0 == b<0) && (t<0!=a<0)     Signed overflow 
  ```
+ `leaq` instruction does not alter any condition codes
+ All other instructions in figure 3.10 cause the flag code to be set
   |Operation|CF|ZF|SF|OF|
   |:-:|:-:|:-:|:-:|:-:|
   |Logical|0|||0|
   |shift|last bit shift out|||0|
   |INC/DEC|unchanged|changed||changed|
+ CMP also set the condition codes. It behave the same way as the SUB instructions 
+ TEST behave in the same manner as the AND instruction.
   Usage: 
   + testq %rax %rax
   + testq mask operand to be test

### 3.6.2 Accessing the Condition Codes
+ SET instructions
  Destination: low-order single-byte register elements or a single-byte memory location.
+ Signed: SF ^ OF check a < b and ZF check a = b
  Unsigned: CF check a < b and  ZF check a = b
___
```c
int comp(data_t a, data_t b){
   return a COMP b;
}
```
A. 
B. 
C. 
D. 
___






