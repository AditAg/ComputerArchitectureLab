#Q2

.text
main:

lui $t1,0x1000
lui $t2,0x2000
ori $t1,0x0001
ori $t2,0x0002
add $v0,$t1,$t2

