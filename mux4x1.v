module mux4x1 #(parameter DATA_WIDTH = 1)(

    input [DATA_WIDTH-1:0] in_a , in_b , in_c , in_d ,
    input [1:0] select ,
    input enable ,

    output [DATA_WIDTH-1:0] out
);

    wire [DATA_WIDTH-1:0] out_w , and1_w , and2_w , and3_w , and4_w;

    not not1 (notSelect0 , select[0]);
    not not2 (notSelect1 , select[1]);

    and and1 [6:0] (and1_w , in_a , notSelect1 , notSelect0);
    and and2 [6:0] (and2_w , in_b , notSelect1 , select[0]);
    and and3 [6:0] (and3_w , in_c , select[1]  , notSelect0);
    and and4 [6:0] (and4_w , in_d , select[1]  , select[0]);

    or or1 [6:0] (out_w , and1_w , and2_w , and3_w , and4_w);

    //enable 

    and andEnable [6:0] (out , out_w , enable);

endmodule