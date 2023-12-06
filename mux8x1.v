// module mux8x1 #(parameter DATA_WIDTH = 35) 
// (
//     input [DATA_WIDTH-1:0] in_a , in_b , in_c , in_d , in_e , in_f , in_g , in_h ,
//     input [2:0] select , 
//     input enable ,

//     output [DATA_WIDTH-1:0] out
// );

//     wire [DATA_WIDTH-1:0] mux1_w , mux2_w , and1_w , and2_w;

//     not not1 (notSelect2 , select[2]);

//     mux4x1 mux4x1_1 (
//         .in_a   (in_a) ,
//         .in_b   (in_b) ,
//         .in_c   (in_c) ,
//         .in_d   (in_d) ,
//         .select (select[1:0]) ,
//         .enable (notSelect2) ,

//         .out    (mux1_w)
//     );

//     mux4x1 mux4x1_2 (
//         .in_a   (in_e) ,
//         .in_b   (in_f) ,
//         .in_c   (in_g) ,
//         .in_d   (in_h) ,
//         .select (select[1:0]) ,
//         .enable (select[2]) ,

//         .out    (mux2_w)
//     );

//     or or1 [34:0] (out , mux1_w , mux2_w);

    
// endmodule

module mux8x1
(
    input in_a , in_b , in_c , in_d , in_e , in_f , in_g , in_h ,
    input [2:0] select , 
    input enable ,

    output out
);

    wire mux1_w , mux2_w , and1_w , and2_w;

    not not1 (notSelect2 , select[2]);

    //enable

    and andEnable1 (enable1 , notSelect2 , enable);
    and andEnable2 (enable2 , select[2] , enable);

    mux4x1 mux4x1_1 (
        .in_a   (in_a) ,
        .in_b   (in_b) ,
        .in_c   (in_c) ,
        .in_d   (in_d) ,
        .select (select[1:0]) ,
        .enable (enable1) ,

        .out    (mux1_w)
    );

    mux4x1 mux4x1_2 (
        .in_a   (in_e) ,
        .in_b   (in_f) ,
        .in_c   (in_g) ,
        .in_d   (in_h) ,
        .select (select[1:0]) ,
        .enable (enable2) ,

        .out    (mux2_w)
    );

    or or1 (out , mux1_w , mux2_w);

endmodule