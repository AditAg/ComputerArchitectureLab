# ComputerArchitectureLab
There are a few points to take care:
1) Whenever a syscall is made, the system looks in a0 register for the value to be loaded provided the correct system call instruction.
2) $ti's are the temporary registers used inside functions whereas the si's are the share registers whose values often need to be stored in the stack to retrieve it after function calls. (This is by convention)
