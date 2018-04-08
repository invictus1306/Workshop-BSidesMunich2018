.text
.global _start
 
_start:
  mov r0, #0      @ argument
  mov r7, #1      @ exit syscall
  swi 0           @ execute syscall