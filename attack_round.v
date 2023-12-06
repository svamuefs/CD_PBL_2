module attack_round #(
    parameter DATA_WIDTH = 35 ,
    COLUNE_SIZE = 7 ,
    TOTAL_COLUNES = 5
) (

    input [DATA_WIDTH-1:0] selected_map ,
    input [2:0] x_coord_code , y_coord_code ,
    input enable , enableAttack ,  confirmAttack ,

    output [DATA_WIDTH-1:0] matriz_data ,
    output [1:0] ledRgb
    
);

    not notConfirmAttack (confirmAttack_w , confirmAttack); // !!

    wire [DATA_WIDTH-1:0] hits_map_clk , hits_map_out , notHitsMapOut;
    wire [COLUNE_SIZE-1:0] hits_map_clk_colune , selected_map_colune;

    d_flipflop selected_map_register [DATA_WIDTH-1:0] (
        .d     (selected_map) ,
        .clk   (hits_map_clk) ,//!!
        .reset (enable) ,//!!
					.initial_value (1'b1) ,

        .out   (matriz_data)
    );

    //d_flipflop hits_map_register [DATA_WIDTH-1:0] (
    //    .d     (1'b1) , //!!
    //    .clk   (hits_map_clk) ,
    //    .reset (enable) , //!!

    //    .out   (hits_map_out)
    //);

    //salva a coordena do ataque na matriz de tiros

    //not notMatriz [34:0] (notHitsMapOut , hits_map_out);

    //or orMatriz [34:0] (matriz_data , selected_map_out , notHitsMapOut);

    demux1x8 yCoordDemuxHitsMap (
        .in     (confirmAttack_w) , 
        .select (y_coord_code) ,
        .enable (enableAttack) ,// !!

        .out_b  (hits_map_clk_colune[0]) ,
        .out_c  (hits_map_clk_colune[1]) ,
        .out_d  (hits_map_clk_colune[2]) ,
        .out_e  (hits_map_clk_colune[3]) ,
        .out_f  (hits_map_clk_colune[4]) ,
        .out_g  (hits_map_clk_colune[5]) ,
        .out_h  (hits_map_clk_colune[6]) 
    );

    demux1x8 xCoordDemuxHitsMap [COLUNE_SIZE-1:0] (
        .in     (hits_map_clk_colune) , 
        .select (x_coord_code) ,
        .enable (enableAttack) ,// !!
        
        .out_b  (hits_map_clk[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .out_c  (hits_map_clk[(COLUNE_SIZE*4)-1:COLUNE_SIZE*3]) ,
        .out_d  (hits_map_clk[(COLUNE_SIZE*3)-1:COLUNE_SIZE*2]) ,
        .out_e  (hits_map_clk[(COLUNE_SIZE*2)-1:COLUNE_SIZE*1]) ,
        .out_f  (hits_map_clk[COLUNE_SIZE-1:0])
    );


    //Indicar acerto ou erro atraves do led rgb

    mux8x1 xCoordMuxSelectedMap [COLUNE_SIZE-1:0] (
        .in_b   (selected_map[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .in_c   (selected_map[(COLUNE_SIZE*4)-1:COLUNE_SIZE*3]) ,
        .in_d   (selected_map[(COLUNE_SIZE*3)-1:COLUNE_SIZE*2]) ,
        .in_e   (selected_map[(COLUNE_SIZE*2)-1:COLUNE_SIZE*1]) ,
        .in_f   (selected_map[COLUNE_SIZE-1:0]) ,
        .select (x_coord_code) ,
        .enable (enableAttack) ,// !!

        .out    (selected_map_colune)
    );

    mux8x1 yCoordMuxSelectedMap (
        .in_b   (selected_map_colune[0]) ,
        .in_c   (selected_map_colune[1]) ,
        .in_d   (selected_map_colune[2]) ,
        .in_e   (selected_map_colune[3]) ,
        .in_f   (selected_map_colune[4]) ,
        .in_g   (selected_map_colune[5]) ,
        .in_h   (selected_map_colune[6]) , 
        .select (y_coord_code) ,
        .enable (enableAttack) ,// !!

        .out    (ledRgbRed)
    );

    not notRed (ledRgbGreen , ledRgbRed);

    and andGreen (ledRgb[0] , ledRgbGreen , confirmAttack_w);
    and andRed   (ledRgb[1] , ledRgbRed   , confirmAttack_w);

    
endmodule