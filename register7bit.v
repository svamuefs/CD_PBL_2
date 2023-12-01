module register7bit (
    input in , clk , reset , 
    output [6:0] out
);
    
    d_flipflop d_flipflop_0 (
        .d(in) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_1)
    );

    and and1(out[6] , dff_out_1);

    d_flipflop d_flipflop_1 (
        .d(dff_out_1) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_2)
    );

    and and2(out[5] , dff_out_2);

    d_flipflop d_flipflop_2 (
        .d(dff_out_2) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_3)
    );

    and and3(out[4] , dff_out_3);

    d_flipflop d_flipflop_3 (
        .d(dff_out_3) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_4)
    );

    and and4(out[3] , dff_out_4);

    d_flipflop d_flipflop_4 (
        .d(dff_out_4) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_5)
    );

    and and5(out[2] , dff_out_5);

    d_flipflop d_flipflop_5 (
        .d(dff_out_5) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_6)
    );

    and and6(out[1] , dff_out_6);

    d_flipflop d_flipflop_6 (
        .d(dff_out_6) ,
        .clk(clk) ,
        .reset(reset) ,
        .out(dff_out_7)
    );

    and and7(out[0] , dff_out_7);

endmodule