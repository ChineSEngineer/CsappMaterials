#Chapter 1: A Tour of Computer Systems
##1.1 Information Is Bits + Context
The source program is a sequence of bits, each with a value of 0 or 1， organized in 8-bit chunks called bytes. Each byte represents some text character in the program.

Files such as hello.c that consist exclusively of ASCII characters are known as text files. All other files are known as binary files.

##1.2 Programs Are Translated by Other Programs into Different Forms
| hello.c | | hello.i | | hello.s | | hello.o | | hello | 
| ------- |-| ------- |-| ------- |-| ------- |-|-------|
| Source | Preprocessor | Modified Source | Compiler | Assembly | Assembler | Relocatable object programs | Executable | Executable object |

+ Preprocessor Phase
Read stdio.h and insert it directly
+ Compilation phase
```c
1 main:
2 subq $8, %rsp
3 movl $.LCO, %edi
4 call puts
5 movl $0, %eax
6 addq $8, %rsp
7 ret
```
+ Assembly Phase
Convert to a 17 byte relocatble object program
+ Linking phase
Merge printf.o and hello.o

##1.3 It Pays to Understand How Compilation Systems Work
+ Optimizing program performance
+ Understanding link-time errors
+ Avoiding security holes

##1.4 Processors Read and Interpret Instructions Stored in Meomory
###1.4.1 Hardware Organization of a System
+ **Buses**
Os based byte-sized word: 4 bytes or 8 bytes
+ **I/O Device**
Contrallers(chip sets on motherboard) and Adaptors(plugged-in card)
+ **Main Memory** 
Physically, main memory consists of a collection of dynamic random access memory(DRAM) chips. Logically, memory is organized as a linear array of bytes, each with its own unique address (array index) starting at zero. 
short: 2 bytes
int and float: 4 bytes
long and double: 8 bytes
+ **Processor**
PC: A word-size storage device
Register file: small deice that consists of a collection of word-size registers
Simple operations: 
   + Load(mem => reg)
   + Save(reg => mem)
   + Operate (2 regs => ALU => reg)
   + Junp (extract a word into the PC)

  Instruction Set Architecture vs Microarchitecture

###1.4.2 Running the ==hello== Program
1. Keyboard "Hello" => Register file => Main Memory
2. (Direct Memory Access) Disk "Object file" => Memory
3. After loaded hello object file, run the instructions which will copy "Hello World" string from memory to the register file and then to the display device.

##1.5 Caches Matter
1. Waste of Copy: 
loaded program to memory then copy to processor 
copy "Hello world" to memory then to display device
2. Cache
To deal with processor-memory gap
L1, L2, (L3)
3. Cache

##1.6 Storage Devices From a Hierarchy
> The main idea of a memory hierarchy is that storage at one level serves as a cache for storage at the next lower level.

##1.7 The operating System Manages the Hardware
+ Two purpose:
   1. protect hardware
   2. provide application uniform and simple mechanism
+ Abstraction:
   file => I/O devices
   virtual memory => main memory and disk memory
   processes => processor, main memory, I/O devices
###1.7.1 Processes
> A process is the operating system's abstraction for a running program.
+ Context  switch
   kernel is a portion of code. A system call can tansfer the control to the kernrl.
###1.7.2 Threads
+ A process can have multiple execution unit.
+ Sharing same code and data
+ Usually more efficient because of easily sharing data
###1.7.3 Virtual Memory
|Layout||
| ----------------- | - |
|code and data of all processes | high address |
|code and data of user processes|low address|
From low to high:
+ Program code and data
   >Code begins at the same fixed address for all processes, followed by data locations that correspond toglobal C variables.
+ Heap
   run-time heap, expand dynamically by ==malloc== and ==free==
+ Shared libraries
+ Stack
+ Kernel virtual memory
###1.7.4 Files
>A file is a sequence of bytes, nothing more and nothing less. Every I/O device, including disks, keyboards, displays, and even networks, is modeled as a file. All input and output in the system is performed by reading and writing files, using a small set of system calls known as Unix I/O.
##1.8 System Communicate with Other System Using Networks
##1.9 Important Themes
###1.9.1 Amdahl's Law
$$T_{new} = (1 - \alpha)T_{old} + (\alpha T_{old}) / k$$
$$S = T_{old} / T_{new} = 1 / [(1 - \alpha) + \alpha / k]$$
$$S_\infty=1/(1-\alpha)$$
###1.9.2 Concurrency and Parallelism
Do more and run faster
+ Thread-Level Concurrency
  <table>
    <tr>
       <th rowspan=2>uniprocessors</th>
       <th colspan=2>multiprocessors</th>
    </tr>
    <tr>
       <td>multi-core</td>
       <td>hyper-threaded</td>
    </tr>
   </table>

   + multi-core processors
     Share L3 cache and Main Memory
   + Hyper-threaded processor
     ？？？多线程和多进程区别？？？

***Instruction-Level Parallelism***
Old: 2-5 clock cycles/instruction
New: 100 instructions/clock cycle
Cause: pipelining

***Single-Instruction, Multiple-Data(SIMD) Parallelism***
>Although some compilers attempt to automatically extract SIMD parallelism from C programs, a more reliable method is to write programs using special vector data types supported in compilers such as GCC. We describe this style of programming in Web Aside OPT:SIMD

###1.9.3 The Importance of Abstractions in Computer System
<table>
  <tr>
    <td colspan=4 align=center>Virtual machine</td>
  </tr>
  <tr>
    <td></td>
    <td colspan=3 align=center>Processes</td>
  </tr>
  <tr>
    <td></td>
    <td>Instruction set architecture</td>
    <td colspan=2>Virtual Memory</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td align=center>Files</td>
  </tr>
  <tr>
    <td>Operating system</td>
    <td align=center>Processor</td>
    <td>Main memory</td>
    <td>I/O devices</td>
  </tr>
</table>

Example: 
> On the processor side, the instruction set architecture provides an abstraction of the actual processor hardware. With this abstraction, a machine-code program behaves as if it were executed on a processor that performs just one instruction at a time. The underlying hardware is far more elaborate, executing multiple instructions in parallel, but always in a way that is consistent with the simple, sequential model.


##1.10 Summary

