module demux1x4(
    input in , 
    input [1:0] select ,
    input enable ,

    output out_a , out_b , out_c , out_d
);

    not not1 (notSelect0 , select[0]);
    not not2 (notSelect1 , select[1]);

    and and1 (out_a , in , notSelect1 , notSelect0 , enable);
    and and2 (out_b , in , notSelect1 , select[0]  , enable);
    and and3 (out_c , in , select[1]  , notSelect0 , enable);
    and and4 (out_d , in , select[1]  , select[0]  , enable);
    
endmodule