.intel_syntax noprefix
    .bss
    .lcomm _out_fname, 128
    .equ _string_limit, 4096
    .equ double_upper_limit, 6
    .equ double_lower_limit, -6
    .lcomm double_buffer, 8
    .lcomm double_ex, 8
    .lcomm double_ex2, 8
    .lcomm double_sum_buffer, 8
    .lcomm double_sum_buffer_prev, 8
    .lcomm double_delta, 8
    .lcomm string_buf, _string_limit
    .lcomm substring_buf, _string_limit
    ReadStartTime: .space 16
    ReadEndTime: .space 16
    ReadDeltaTime: .space 16
    CalcStartTime: .space 16
    CalcEndTime: .space 16
    CalcDeltaTime: .space 16
    WriteStartTime: .space 16
    WriteEndTime: .space 16
    WriteDeltaTime: .space 16

    .text
    .global _start
msg_inv_args:
    .string "Invalid args count. See README file for corect usage.\n"
msg_inv_flag:
    .string "Invalid flag. See README file for corect usage.\n"
msg_enter_float:
    .string "Enter the x value: "
msg_gen_float:
    .string "Generated x value: "
msg_result_value:
    .string "Value of ch(x) = "
msg_delta:
    .string "Delta: "
msg_value:
    .string "Value: "
msg_err:
    .string "Error while opening a file: "
msg_inv_float:
    .string "Wrong float number format\n"
msg_warning:
    .string "Preffered range is [-6;6]. Accuracy might be lower than expected!\n"
msg_time:
    .string "Elapsed time:  \n"
msg_time_read:
    .string "Read:          "
msg_time_calc:
    .string "Calculations:  "
msg_time_write:
    .string "Write:         "
flag_file:
    .string "-f"
flag_random:
    .string "-r"
flag_console:
    .string "-c"

_start:
    mov r12, [rsp]
    cmp r12, 2                          # check number of args
    jl inv_args_count                   # if < 2 display error message                                 
    mov rcx, 16[rsp]
    mov rax, rcx
    mov rbx, offset flag_console
    call string_compare
    cmp rax, 1
    je .console_input
    mov rax, rcx
    mov rbx, offset flag_random
    call string_compare
    cmp rax, 1
    je .random_input
    mov rax, rcx
    mov rbx, offset flag_file
    call string_compare
    cmp rax, 1
    je .file_input
    mov rax, offset msg_inv_flag
    call console_write_string
    jmp exit

.console_input:
    mov rax, offset msg_enter_float
    call console_write_string
    call console_read_float
    finit
    movq double_buffer, xmm0
    fld qword ptr [double_buffer]
    mov rax, double_upper_limit
    movq double_buffer, rax
    fild qword ptr [double_buffer]
    fcomip
    fstp ST(0)
    ja .ci_next
    mov rax, offset msg_warning
    call console_write_string
    jmp .ci_next2
    .ci_next:
    movq double_buffer, xmm0
    fld qword ptr [double_buffer]
    mov rax, double_lower_limit
    movq double_buffer, rax
    fild qword ptr [double_buffer]
    fcomip
    fstp ST(0)
    jbe .ci_next2
    mov rax, offset msg_warning
    call console_write_string
    .ci_next2:
    mov rax, offset msg_gen_float
    call console_write_string
    call console_write_float
    call console_new_line
    movq r12, xmm0
    mov r15, 0
    jmp .do_task

.random_input:
    cmp r12, 4
    jne inv_args_count
    mov rax, 24[rsp]                            # get lower rand value
    call string_to_number
    mov rcx, rax                                # save it to rcx
    mov rax, 32[rsp]                            # get upper rand value
    call string_to_number
    mov rbx, rax
    cmp rbx, double_upper_limit
    jle .ri_next
    mov rax, offset msg_warning
    call console_write_string
    jmp .ri_next2
    .ri_next:
    cmp rcx, double_lower_limit
    jge .ri_next2
    mov rax, offset msg_warning
    call console_write_string
    .ri_next2:
    mov rax, rcx
    call get_random_number
    cvtsi2sd xmm0, rax
    movq r12, xmm0                                # store x in r12
    mov r15, 0
    mov rax, offset msg_gen_float
    call console_write_string
    call console_write_float
    call console_new_line
    jmp .do_task

.file_input:
    lea rax, ReadStartTime[rip]
    call time_now
    cmp r12, 4
    jne inv_args_count

    mov rax, 24[rsp]                    # store in rax filename input
    mov rdx, rax
    mov rbx, 0                          # 0 - read
    call file_open

    cmp rax, -1                         # if error
    jl .file_open_error

    push rax                            # push file descriptor
    call file_read_line                 # read x value from file
    mov rax, offset _str_buffer
    call string_to_float
    mov rax, offset msg_gen_float
    call console_write_string
    call console_write_float
    call console_new_line
    movq r12, xmm0                        # store x in r12
    pop rax
    call file_close

   

    mov rax, 32[rsp]
    mov rbx, offset _out_fname          # save output filename
    call string_copy
    lea rax, ReadEndTime[rip]
    call time_now
    mov r15, 1
    jmp .do_task

    
.do_task:
    lea rax, CalcStartTime[rip]
    call time_now
   
    mov r13, r12
    finit
    movq double_buffer, r13
    fld qword ptr [double_buffer]
    fchs                                        # store in r13 -x value
    fstp qword ptr [double_buffer]
    movq r13, double_buffer

    xor r14, r14                                # counter for repeating main loop
    .do_task_time_loop:
    finit
    fldz
    fstp qword ptr [double_sum_buffer]
    fldz
    fstp qword ptr [double_sum_buffer_prev]                       
    xor rcx, rcx
    .do_task_loop:
        cmp rcx, 20
        jge .do_task_exit
        
        finit                                   # e^x
        movq xmm0, r12
        mov rax, rcx
        call pow_double
        movq double_buffer, xmm0
        fld qword ptr [double_buffer]
        mov rax, rcx
        call factorial
        movq double_buffer, rax
        fild qword ptr [double_buffer]
        fdivp
        fstp qword ptr [double_ex]

        finit
        fld qword ptr [double_ex]
        fld qword ptr [double_sum_buffer]
        faddp
        fstp qword ptr [double_sum_buffer]
        
        finit                                   # calculate delta
        fld qword ptr [double_sum_buffer]
        fld qword ptr [double_sum_buffer_prev]
        fsubp
        fstp qword ptr [double_delta]
        movq xmm0, double_sum_buffer
        movq double_sum_buffer_prev, xmm0

        cmp r15, 0
        jg .dtln
        mov rax, offset msg_delta
        call console_write_string
        movq xmm0, double_delta
        call console_write_float
        mov rax, '\t'
        call console_write_char
        mov rax, offset msg_value
        call console_write_string
        movq xmm0, double_sum_buffer
        call console_write_float
        call console_new_line
        .dtln:
        add rcx, 2
        jmp .do_task_loop
    .do_task_exit:
    debug:
    cmp r15, 0
    je .dttl_exit
    inc r14
    cmp r14, 10000000
    jl .do_task_time_loop
    .dttl_exit:
    lea rax, CalcEndTime[rip]
    call time_now
    cmp r15, 0
    jg .file_output
    jmp .console_output

.console_output:
    mov rax, offset msg_result_value
    call console_write_string
    movq xmm0, double_sum_buffer
    call console_write_float
    call console_new_line
    jmp exit

.file_output:
    lea rax, WriteStartTime[rip]
    call time_now
    mov rax, offset _out_fname
    call file_create
    mov rbx, 289                        # write + append
    mov rax, offset _out_fname
    call file_open
    mov r13, rax

    movq xmm0,  double_sum_buffer
    call file_write_float

    mov rax, r13
    call file_close
    lea rax, WriteEndTime[rip]
    call time_now

.print_time:
    # print time results for file IO
    # for read
    mov rax, ReadStartTime[rip]
    mov rbx, ReadStartTime[rip + 8]
    mov rcx, ReadEndTime[rip]
    mov rdx, ReadEndTime[rip + 8]
    lea r8, ReadDeltaTime[rip]
    lea r9, ReadDeltaTime[rip + 8]
    call get_delta

    # for calc
    mov rax, CalcStartTime[rip]
    mov rbx, CalcStartTime[rip + 8]
    mov rcx, CalcEndTime[rip]
    mov rdx, CalcEndTime[rip + 8]
    lea r8, CalcDeltaTime[rip]
    lea r9, CalcDeltaTime[rip + 8]
    call get_delta
    
    # for write
    mov rax, WriteStartTime[rip]
    mov rbx, WriteStartTime[rip + 8]
    mov rcx, WriteEndTime[rip]
    mov rdx, WriteEndTime[rip + 8]
    lea r8, WriteDeltaTime[rip]
    lea r9, WriteDeltaTime[rip + 8]
    call get_delta

    
    mov rax, offset msg_time
    call console_write_string

    mov rax, offset msg_time_read
    call console_write_string
    mov rax, ReadDeltaTime[rip]
    call console_write_number
    mov rax, '.'
    call console_write_char
    mov rax, ReadDeltaTime[rip+8]
    call console_write_number
    call console_new_line
    
    mov rax, offset msg_time_calc
    call console_write_string
    mov rax, CalcDeltaTime[rip]
    call console_write_number
    mov rax, '.'
    call console_write_char
    mov rax, CalcDeltaTime[rip+8]
    call console_write_number
    call console_new_line

    mov rax, offset msg_time_write
    call console_write_string
    mov rax, WriteDeltaTime[rip]
    call console_write_number
    mov rax, '.'
    call console_write_char
    mov rax, WriteDeltaTime[rip+8]
    call console_write_number
    call console_new_line    
    jmp exit

.file_open_error:
    mov rax, offset msg_err
    call console_write_string
    mov rax, rdx
    call console_write_string
    call console_new_line
    jmp exit

.inv_float:
    mov rax, offset msg_inv_float
    call console_write_string
    jmp exit

inv_args_count:
    mov rax, offset msg_inv_args
    call console_write_string
    jmp exit         

exit:
	mov rax, 60
	mov rdi, 0
	syscall
