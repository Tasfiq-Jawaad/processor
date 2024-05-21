(SET_VARIABLE)
    @R4
    D=A
    @ITERATION_COUNT //@16
    M=D

    @R8
    D=A
    @ROTATE_ITERATION_COUNT //@17
    M=D


    @R2
    D=M

    @255
    D=A&D

    @RIGHT_BITS //@18
    M=D

    @R2
    D=M

    @32640
    D=A

    @LEFT_EIGHT_BIT_MASK //@19
    M=D
    D=M+D
    M=D
    D=M

    @LEFT_BITS //@19
    M=D

    @R2
    D=M

    @LEFT_BITS //@19
    M=D&M
    D=M

    @ROTATE_EIGHT_TIMES //98
    0;JMP



    


(MAIN)
    @ITERATION_COUNT
    D=M
    @MAIN_LOOP_END
    D; JLE


(Function)
    @R2
    D=A
    @XOR_COUNT //@16
    M=D

    @RIGHT_BITS //@18
    D=M
    
    @NEXT_LEFT_BIT //@21
    M=D
    
    @TEMP_A //@22
    M=D
    @R1
    D=!M
    @LEFT_EIGHT_BIT_MASK
    D=D-M
    @TEMP_B //@23
    M=D

(XOR)
        //@TEMP_A //@19
        //M=D

        //@TEMP_B //@20
        //M=A

        @XOR_COUNT
        D=M
        @SKIP_NEXT_SWAP
        D; JGT

        @NEXT_RIGHT_BITS
        D=M
        @RIGHT_BITS
        M=D

        @NEXT_LEFT_BIT
        D=M
        @LEFT_BITS
        M=D

        @ITERATION_COUNT
        M=M-1

        @DERIVE_KEY
        0;JMP

    (SKIP_NEXT_SWAP)
        @TEMP_A
        D=!M

        @TEMP_B
        D=D&M // A and not B

        @TEMP_A_NOT_B
        M=D // storing (A and not B)

        @TEMP_B
        D=!M // (not A and B)
        
        @TEMP_A
        D=D&M // not A

        @TEMP_A_NOT_B
        D=D|M // (not A and B) or (A and not B)

        @NEXT_RIGHT_BITS //@22
        M=D

        @TEMP_A
        M=D
        

        @LEFT_BITS
        D=M
        @TEMP_B
        M=D

        @XOR_COUNT
        M=M-1


        @XOR
        0;JMP


(DERIVE_KEY)
        @LSB //@20

        M=0    // Initialize lsb mask to 0

        @R1
        D=M

        @128
        D=D&A

        @DERL1_SKIP
        D; JLE // Skip the next step if msb is zero

        @LSB

        M=1    // Set lsb to 1 to match msb 

        @128
        D=A

        @R1
        M=M-D

(DERL1_SKIP)
        @R1
        D=M
        MD=D+M // Shift data left by 1 (D still has data in it)

        @LSB

        D=D+M  // Add in the lsb

        @R1
        M=D

        @MAIN
        0; JMP // Return to calling code


(ROTATE_EIGHT_TIMES)

        @ROTATE_ITERATION_COUNT // Number of times to rotate the value

        D=M

        @MAIN

        D;JLE  // Exit loop when shift amount is <=0

        @LSB

        M=0    // Initialize lsb mask to 0

        @LEFT_BITS

        D=M    // Load data value into memory

        @ROTL1_SKIP

        D; JGE // Skip the next step if msb is zero

        @LSB

        M=1    // Set lsb to 1 to match msb 

(ROTL1_SKIP)
        @LEFT_BITS

        MD=D+M // Shift data left by 1 (D still has data in it)

        @LSB

        D=D+M  // Add in the lsb

        @LEFT_BITS
        M=D

        @ROTATE_ITERATION_COUNT
        M=M-1

        @ROTATE_EIGHT_TIMES
        0; JMP // Return to calling code

(MAIN_LOOP_END)

        @LEFT_BITS
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M
        M=M+D
        D=M

        @RIGHT_BITS
        D=M+D
        
        @R0
        M=D


        @END

(END)

        0; JMP // Infinite loop to stall simulator