module full_display_decoder #(
    parameter DATA_WIDTH = 35 ,
    COLUNE_SIZE = 7 ,
    TOTAL_COLUNES = 4 

) ( 
    input [2:0] status_code , x_coord_code , y_coord_code ,
    input enable , enableAttack ,
    output [DATA_WIDTH-1:0] display_data
);

    //quarta coluna (->4<-321)
    colune_display_decoder status_decoder(
        .binary_code (status_code) ,
        .enable      (enable) ,
        .digitOut    (display_data[COLUNE_SIZE*4-1:COLUNE_SIZE*3])
    );

    //terceira coluna (4->3<-21)

    and andDisplaydata [6:0] (display_data[COLUNE_SIZE*3-1:COLUNE_SIZE*2] , 1'b1); // !!

    //segunda coluna (43->2<-1)
    colune_display_decoder x_coord_decoder(
        .binary_code (status_code) ,
        .enable      (enableAttack) ,
        .digitOut    (display_data[COLUNE_SIZE*2-1:COLUNE_SIZE])
    );

    //primeira coluna (432->1<-)
    colune_display_decoder y_coord_decoder(
        .binary_code (status_code) ,
        .enable      (enableAttack) ,
        .digitOut    (display_data[DATA_WIDTH-1:0])
    );


endmodule