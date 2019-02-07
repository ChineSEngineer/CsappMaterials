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
+  Sizw
   ![Sizes_of_C_dataypes_in_x86-64](http://pluetc9gi.bkt.gdipper.com/Size_of_C_data_types_in_x86-64.png)


















