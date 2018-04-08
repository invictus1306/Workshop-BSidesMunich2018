.text
.global _start
_start:
  @ execve("/bin/sh",["/bin/sh", 0], 0)
 
  add r0, pc, #28  @PC-relative addressing
  mov r2, #0
  push {r0, r2}
  mov r1, sp
  mov r7, #11
  swi 0
_exit:
  mov r0, #0
  mov r7, #1
  swi #0 @ exit
shell: .asciz "/bin/sh"
