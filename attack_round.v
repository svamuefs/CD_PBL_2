module attack_round #(
    parameter  = DATA_WIDTH = 35 ,
    COLUNE_SIZE = 7 ,
    TOTAL_COLUNES = 5
) (

    input [DATA_WIDTH-1:0] selected_map ,
    input [2:0] x_coord_code , y_coord_code ,
    input enable , confirmAttack ,

    output [DATA_WIDTH-1:0] matriz_data
    
);

    not notConfirmAttack (confirmAttack_w , confirmAttack); // !!

    wire [DATA_WIDTH-1:0] selected_map_out , hits_map_clk , hits_map_out , notHitsMapOut;
    wire [COLUNE_SIZE-1:0] hits_map_clk_colune;

    d_flipflop selected_map_register [DATA_WIDTH-1:0] (
        .d     (selected_map) ,
        .clk   (enable) ,//!!
        .reset (enable) ,//!!

        .out   (selected_map_out)
    );

    d_flipflop hits_map_register [DATA_WIDTH-1:0] (
        .d     (1) , //!!
        .clk   (hits_map_clk) ,
        .reset (enable) , //!!

        .out   (hits_map_out)
    );

    not notMatriz [34:0] (notHitsMapOut , hits_map_out);

    or orMatriz [34:0] (matriz_data , selected_map_out , notHitsMapOut);

    mux8x1 #(.DATA_WIDTH(COLUNE_SIZE)) xCoordMux (
        .in_a   (hits_map_clk[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .in_b   (hits_map_clk[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .in_c   (hits_map_clk[(COLUNE_SIZE*4)-1:COLUNE_SIZE*3]) ,
        .in_d   (hits_map_clk[(COLUNE_SIZE*3)-1:COLUNE_SIZE*2]) ,
        .in_e   (hits_map_clk[(COLUNE_SIZE*2)-1:COLUNE_SIZE*1]) ,
        .in_f   (hits_map_clk[COLUNE_SIZE-1:0]) ,
        .in_g   (hits_map_clk[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) ,
        .in_h   (hits_map_clk[(COLUNE_SIZE*5)-1:COLUNE_SIZE*4]) , 
        .select (x_coord_code) ,
        .enable (enable) ,// !!

        .out    (hits_map_clk_colune)
    );
    demux1x8 yCoordDemux (
        .in     (confirmAttack_w) , 
        .select (y_coord_code) ,
        .enable (enable) ,// !!
        
        .out_a  (hits_map_clk_colune[0]) ,
        .out_b  (hits_map_clk_colune[0]) ,
        .out_c  (hits_map_clk_colune[1]) ,
        .out_d  (hits_map_clk_colune[2]) ,
        .out_e  (hits_map_clk_colune[3]) ,
        .out_f  (hits_map_clk_colune[4]) ,
        .out_g  (hits_map_clk_colune[5]) ,
        .out_h  (hits_map_clk_colune[6]) 
    );

    
endmodule