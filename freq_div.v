module freq_div (
    input clk , 
    output final_clk  
);

    wire [14:0] intermediary_clk;

    t_flipflop t_flipflop_0 (
		  .clk (clk) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[0]));

    t_flipflop t_flipflop_1 (
        .clk (intermediary_clk[0]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[1]));

    t_flipflop t_flipflop_2 (
        .clk (intermediary_clk[1]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[2]));
    
    t_flipflop t_flipflop_3 (
        .clk (intermediary_clk[2]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[3])
    );

    t_flipflop t_flipflop_4 (
        .clk (intermediary_clk[3]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[4])
    );

    t_flipflop t_flipflop_5 (
        .clk (intermediary_clk[4]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[5])
    );

    t_flipflop t_flipflop_6 (
        .clk (intermediary_clk[5]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[6])
    );
    
    t_flipflop t_flipflop_7 (
        .clk (intermediary_clk[6]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[7])
    );

    t_flipflop t_flipflop_8 (
        .clk (intermediary_clk[7]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[8])
    );

    t_flipflop t_flipflop_9 (
        .clk (intermediary_clk[8]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[9])
    );

    t_flipflop t_flipflop_10 (
        .clk (intermediary_clk[9]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[10])
    );

    t_flipflop t_flipflop_11 (
        .clk (intermediary_clk[10]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[11])
    );

    t_flipflop t_flipflop_12 (
        .clk (intermediary_clk[11]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[12])
    );

    t_flipflop t_flipflop_13 (
        .clk (intermediary_clk[12]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[13])
    );

    t_flipflop t_flipflop_14 (
        .clk (intermediary_clk[13]) ,
        .t (1) , 
        .reset (1) , 
        .out (intermediary_clk[14])
    );

    t_flipflop t_flipflop_15 (
        .clk (intermediary_clk[14]) ,
        .t (1) , 
        .reset (1) , 
        .out (final_clk)
    );

endmodule