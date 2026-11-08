.global _start

.text
_start:
    # 1. Verify Arithmetic (addi and add)
    li      x1, 10              # Load immediate 10 into t0
    li      x2, 20              # Load immediate 20 into t1
    add     x3, x2, x1          # t2 = t0 + t1 (Expected: 30)
    
    li      x4, 30              # Load expected value
    bne     x4, x3, test_fail   # If t2 != 30, go to fail

test_pass:
    # Exit with code 0 (Success)
    li     x31, -1
    ebreak                       

test_fail:
    # Exit with code 1 (Failure)
    li      x31, 1               
    ebreak                       


