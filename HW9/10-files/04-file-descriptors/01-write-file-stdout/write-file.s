# Sample program that writes to a new file.
.eqv	NAME_SIZE 256	# Размер буфера для имени файла

        .data
default_name: .asciz "testout.txt"      # Имя файла по умолчанию
# Это выводимый текст
buffer: .asciz "The quick brown fox jumps over the lazy dog."
file_name: .space	NAME_SIZE		# Имя читаемого файла

        .text
main:
    la   a0, default_name # Имя файла по умолчани
    ###############################################################
out:
    # Open (for writing) a file that does not exist
    li   a7, 1024     # system call for open file
    li   a1, 1        # Open for writing (flags are 0: read, 1: write)
    ecall             # open a file (file descriptor returned in a0)
    mv   s6, a0       # save the file descriptor
    ###############################################################
    # Write to file just opened
    li   a7, 64       # system call for write to file
    mv   a0, s6       # file descriptor
    la   a1, buffer   # address of buffer from which to write
    li   a2, 44       # hardcoded buffer length
    ecall             # write to file
    ###############################################################
    # Close the file
    li   a7, 57       # system call for close file
    mv   a0, s6       # file descriptor to close
    ecall             # close file
    ###############################################################
    # Write to stdout using syscall
    li   a7, 64       # system call for write to file
    li   a0, 1        # stdout descriptor test
#    mv   a0, s6       # file descriptor
    la   a1, buffer   # address of buffer from which to write
    li   a2, 44       # hardcoded buffer length
    ecall             # write to file
