///
// Bootstrap Loader for Hard Disk and Tape
//
// rom.v
// to be included from the top module at the compile

`define MEM(x, y) {mem_hi[(x)>>1], mem_lo[(x)>>1]}=y

initial
begin
// SWR (Console Switches Register, 777570)
REG_SWR = 16'o173700; // UNIX V1 multi user mode
//REG_SWR = 16'o073700; // UNIX V1 single user mode
//REG_SWR = 16'o173030; // UNIX V6 single user mode

// for UNIX V1 (load from RF)
`MEM('o773000, 16'o012737); // mov #340,@#177776 // PS=340
`MEM('o773002, 16'o000340);
`MEM('o773004, 16'o177776);
`MEM('o773006, 16'o000137); // jmp @#173700 (=773700)
`MEM('o773010, 16'o173700);

`MEM('o773700, 16'o012700); // mov #177472,r0
`MEM('o773702, 16'o177472);
`MEM('o773704, 16'o012740); // mov #3,-(r0)     // DAE=3
`MEM('o773706, 16'o000003);
`MEM('o773710, 16'o012740); // mov #14000,-(r0) // DAR=14000
`MEM('o773712, 16'o140000);
`MEM('o773714, 16'o012740); // mov #54000,-(r0) // CMA=54000
`MEM('o773716, 16'o054000);
`MEM('o773720, 16'o012740); // mov #-2000,-(r0) // WC=-2000
`MEM('o773722, 16'o176000);
`MEM('o773724, 16'o012740); // mov #5, -(r0)    // DCS=5
`MEM('o773726, 16'o000005);
`MEM('o773730, 16'o105710); // tstb (r0)
`MEM('o773732, 16'o002376); // bge .-2
`MEM('o773734, 16'o000137); // jmp @#54000
`MEM('o773736, 16'o054000);

// for UNIX V6 (load from RK)
`MEM('o774000, 16'o012737); // mov #340,@#177776 // PS=340
`MEM('o774002, 16'o000340);
`MEM('o774004, 16'o177776);
`MEM('o774006, 16'o000137); // jmp @#174700 (=774700)
`MEM('o774010, 16'o174700);

`MEM('o774700, 16'o012700); // mov #177412,r0
`MEM('o774702, 16'o177412);
`MEM('o774704, 16'o005010); // clr (r0)  // RKDA=0
`MEM('o774706, 16'o005040); // clr -(r0) // RKBA=0
`MEM('o774710, 16'o012740); // 
`MEM('o774712, 16'o177400); // mov #-400,-(r0) // WC=-400
`MEM('o774714, 16'o012740); // mov #5, -(r0)   // DCS=5
`MEM('o774716, 16'o000005);
`MEM('o774720, 16'o105710); // tstb (r0)
`MEM('o774722, 16'o002376); // bge .-2
`MEM('o774724, 16'o005007); // clr pc (jmp @#00000)


// Bootstrap Loader for tape
//
//                        LOAD=xx7400          ; Buffer start address
//
//                        .=LOAD+0344          ; Start address of bootstrap loader (xx7744)
//
//xx7744  016701  START:  MOV DEVICE, R1       ; Get reader CSR address
//xx7746  000026
//xx7750  012702  LOOP:   MOV #.-LOAD+2, R2    ; Get buffer pointer
//xx7752  000352                               ;   (<--- pointer to buffer)
//xx7754  005211          INC @R1              ; Enable the paper tape reader
//xx7756  105711  WAIT:   TSTB @R1             ; Wait until data available
//xx7760  100376          BPL WAIT
//xx7762  116162          MOVB 2(R1), LOAD(R2) ; Transfer byte to buffer
//xx7764  000002
//xx7766  xx7400
//xx7770  005267          INC LOOP+2           ; Increment pointer to buffer
//xx7772  177756
//xx7774  000765          BR LOOP              ; Continue reading (<--- modified branch instruction)
//xx7776  yyyyyy  DEVICE: yyyyyy               ; Paper tape reader CSR address

`MEM('o157744, 16'o016701);
`MEM('o157746, 16'o000026);
`MEM('o157750, 16'o012702);
`MEM('o157752, 16'o000352);
`MEM('o157754, 16'o005211);
`MEM('o157756, 16'o105711);
`MEM('o157760, 16'o100376);
`MEM('o157762, 16'o116162);
`MEM('o157764, 16'o000002);
`MEM('o157766, 16'o157400);
`MEM('o157770, 16'o005267);
`MEM('o157772, 16'o177756);
`MEM('o157774, 16'o000765);
`MEM('o157776, 16'o177550);

end
