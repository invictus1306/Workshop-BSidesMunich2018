# Workshop-ARM BSidesMunich2018 
## ARM shellcode and exploit development
### Workshop topics

#### ARM Architecture
* ARM CPU
* Registers
* Instructions
* PC-relative addressing
* Calling convention and Stack frames

#### LAB1 - Debugging on ARM system

#### Shellcode
* syscalls
* Shell spawning shellcode (ARM/Thumb) + LAB2
* Bind TCP shellcode (ARM) + LAB3
* Reverse shell shellcode (ARM)

#### Exploit
* Tools introduction (pwntools, ROPGadget)
* Modify the value of a local variable (stack1) + LAB4
* Vulnerability mitigations
* Ret to libc - Bypass NX and execute a shell with a single  ROP gadget (stack_sh) + LAB5
* Bypass NX with ROP using mprotect (stack_mprotect) + LAB6
* ASLR
* Bypassing NX and ASLR (stack_aslr) + LAB7

### Enviroment
* Raspberry pi 3
* Image: raspbian-2018-03-14 (http://ftp.jaist.ac.jp/pub/raspberrypi/raspbian/images/raspbian-2018-03-14/)
