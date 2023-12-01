module mux8x1 #(parameter DATA_WIDTH = 1) 
(
    input [DATA_WIDTH-1:0] in_a , in_b , in_c , in_d , in_e , in_f , in_g , in_h ,
    input [2:0] select , 
    output [DATA_WIDTH-1:0] out
);

    wire [DATA_WIDTH-1:0] mux1_w , mux2_w , and1_w , and2_w;

    not not1 (notSelect2 , select[2]);


    mux4x1 #(.DATA_WIDTH(DATA_WIDTH)) mux4x1_1 (
        .in_a(in_a) ,
        .in_b(in_b) ,
        .in_c(in_c) ,
        .in_d(in_d) ,
        .select(select[1:0]) ,
        .out(mux1_w)
    );

    mux4x1 #(.DATA_WIDTH(DATA_WIDTH)) mux4x1_2 (
        .in_e(in_e) ,
        .in_f(in_f) ,
        .in_g(in_g) ,
        .in_h(in_h) ,
        .select(select[1:0]) ,
        .out(mux2_w)
    );

    and and1 [DATA_WIDTH-1:0] (and1_w , mux1_w , notSelect2);
    and and2 [DATA_WIDTH-1:0] (and2_w , mux2_w , select[2]);

    or or1 [DATA_WIDTH-1:0] (out , and1_w , and2_w);

    
endmodule