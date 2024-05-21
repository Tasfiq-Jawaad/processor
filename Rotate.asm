// R3 - Original value
// R8 - Temporary value
// R4 - Number of time to rotate
// R2 - lsb bit


(MAIN)

        @R3   // Original

        D=M

        @R8    // R8 hold the temporary value

        M=D 

        // @4     // Number of times to rotate the value

        // D=M   

        // @R1    // R1 holds the rotate amount

        // M=D


        // Loop to rotate value in R1 the amount in R0

(MAIN_TEST)

        @R4 // Number of times to rotate the value

        D=M

        @MAIN_LOOP_END

        D;JLE  // Exit loop when shift amount is <=0

        @R2

        M=0    // Initialize lsb mask to 0

        @R8

        D=M    // Load data value into memory

        @ROTL1_SKIP

        D; JGE // Skip the next step if msb is zero

        @R2

        M=1    // Set lsb to 1 to match msb 

(ROTL1_SKIP)
        @R8

        MD=D+M // Shift data left by 1 (D still has data in it)

        @R2

        D=D+M  // Add in the lsb

        @R8
        M=D

        @R4
        M=M-1

        @MAIN_TEST
        0; JMP // Return to calling code

(MAIN_LOOP_END)

        @R8

        D=M    // Final rotated amount is in D

        @R5
        M=D

        @END

(END)

        0; JMP // Infinite loop to stall simulator