module matriz_displayer #(

    parameter MAP_WIDTH = 35 , 
    parameter COLUNE_SIZE = 7 , 
    parameter LINE_SIZE = 5

) (

    input clk ,
    input [MAP_WIDTH-1:0] map ,
    output [COLUNE_SIZE-1:0] matriz_colune_activator ,
    output [LINE_SIZE-1:0] matriz_lines_data
);

    wire [2:0] counter3bit_out;

    counter3bit counter3bit_1(
        .clk       (clk) , 
        .reset     (reset) ,
        .loopStart (counterLoop) ,
        .out       (counter3bit_out)
    );

    register7bit register7bit_1(
        .in    (counterLoop) , 
        .clk   (clk) , 
        .reset (1) , 
        .out   (matriz_colune_activator)
    );

    mux8x1 #(.DATA_WIDTH(COLUNE_SIZE)) mux8x1_1 (
        .in_a   (map[6:0]) ,
        .in_b   (map[13:7]) ,
        .in_c   (map[20:14]) ,
        .in_d   (map[27:21]) ,
        .in_e   (map[34:28]) ,
        .in_f   (0) ,
        .in_g   (0) ,
        .in_h   (0) , 
        .select (counter3bit_out) ,
        .out    (matriz_lines_data)
    );
    
endmodule