.text
.global _start
_start:
  @ execve("/bin/sh", 0, 0)
  @ r0 = _shell (use the adr instruction)
  @ argv=NULL
  @ envp=NULL
  @ exceve syscall = 11

_exit:
  mov r0, #0
  mov r7, #1
  swi #0            @ exit(0)
  
_shell: .asciz "/bin/sh"
