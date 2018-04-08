.text
.global _start
_start:
  @ execve("/bin/sh", 0, 0)
 
  adr r0, _shell
  mov r1, #0         @ argv=NULL
  mov r2, r1         @ envp=NULL
  mov r7, #11        @ exceve syscall
  
  mov r7, #11
  swi 0
_exit:
  mov r0, #0
  mov r7, #1
  swi #0 @ exit
  
_shell: .asciz "/bin/sh"
