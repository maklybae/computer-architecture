# Example:
#
# for (t0 = 0; t0 < t1; ++t0) {
#     print_int(t0)
#     print_char('\n')
# }
for:
   li   a7, 5
   ecall
   mv   t1, a0
   mv   t0, zero
next:
   bge  t0, t1, end_for
   mv   a0, t0
   li   a7, 1
   ecall
   li   a7, 11
   li   a0, '\n'
   ecall
   addi t0, t0, 1
   j    next
end_for:
   li   a7, 10
   ecall
