module batalha_naval (


    input cpld_clk ,


    output [6:0] matriz_colune_data , display_colune_data ,
	output [4:0] matriz_colune_activator ,
    output [3:0] display_colune_activator ,


    output counter_teste , final_clk_teste ,
    output [10:0] teste ,
    output [34:0] mapteste

 );

    wire [34:0] map;
    wire [27:0] display_data;

    assign map = 35'b00000010000010000010000010000010000;
    assign display_data = 28'b0000001000001000001000001000;
    // 0000001 0000010 0000100 0001000 0010000

    freq_div freq_div_1(
        .clk       (cpld_clk) , 
        .final_clk (clk)
    );

    displayer matriz_displayer (
        .clk              (clk) , 
        .image            (map) ,
        .colune_activator (matriz_colune_activator) ,
        .colune_data      (matriz_colune_data)
    );

    displayer segment_display (
        .clk              (clk) ,
        .image            (display_data) ,
        .colune_activator (display_colune_activator) ,
        .colune_data      (display_colune_data)
    );

endmodule