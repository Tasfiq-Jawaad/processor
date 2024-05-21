    @3
    D=!M

    @4
    D=D&M // A and not B

    @0
    M=D // storing (A and not B)

    @4
    D=!M // (not A and B)
    
    @3
    D=D&M // not A

    @0
    D=D|M // (not A and B) or (A and not B)

    @5
    M=D

(END)
    @END
    0;JMP