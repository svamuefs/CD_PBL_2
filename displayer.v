module displayer #(

    parameter DATA_WIDTH =  35,
    COLUNE_SIZE = 7 ,
    TOTAL_COLUNES = 5

) (

    input [DATA_WIDTH-1:0] image ,
    input clk , enable , 

    output [COLUNE_SIZE-1:0] colune_data ,
    output [TOTAL_COLUNES-1:0] colune_activator
    
);

    wire [2:0] counter3bit_out;

    counter3bit counter3bit_1(
        .clk       (clk) , 
        .reset     (counterEnable) , 
        .mod_value (3'b101) ,

        .loopStart (loopStart) ,
        .loopEnd   (loopEnd) ,
        .out       (counter3bit_out)
    );

    not notLoopEnd (loopReset , loopEnd);
    and andLoopResetEnable (counterEnable , loopReset , enable);

    register8bitSIPO register8bitSIPO_1(
        .in     (loopStart) , 
        .clk    (clk) , 
        .reset  (enable) , 

        .out    (colune_activator)
    );

    mux8x1 mux8x1_1 [COLUNE_SIZE-1:0] (
        .in_a   (image[COLUNE_SIZE-1:0]) ,
        .in_b   (image[(COLUNE_SIZE*2)-1:COLUNE_SIZE]) ,
        .in_c   (image[(COLUNE_SIZE*3)-1:COLUNE_SIZE*2]) ,
        .in_d   (image[(COLUNE_SIZE*4)-1:COLUNE_SIZE*3]) ,
        .in_e   (image[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .select (counter3bit_out) ,
        .enable (enable) ,

        .out    (colune_data)
    );
    
endmodule