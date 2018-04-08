.data
string: .asciz "Hello World!\n"
len = . - string

.text
.global _start

_start:
  mov r0, #1         @ stdout
  ldr r1, =string    @ string address
  ldr r2, =len       @ string length
  mov r7, #1         @ write syscall number is 4 not 1
  swi 0              @ execute syscall

_exit:
  mov r7, #1         @ exit syscall
  swi 0              @ execute syscall
