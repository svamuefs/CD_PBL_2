module batalha_naval (
    input cpld_clk , 
    output [6:0] linha_matriz , 
	output [4:0] coluna_matriz ,
    output mod5counter_teste , final_clk_teste 

 );

    wire [34:0] map;

    assign map = 00001000100010000001001000100000100;
    
    
    freq_div freq_div_1(
        .clk(cpld_clk) , 
        .final_clk(clk)
    );

    matriz_displayer matriz_displayer_1 (
        .clk (clk) , 
        .map (map) ,

    );

endmodule