module imageSelect #(
    parameter DATA_WIDTH = 35
)
(
    input [DATA_WIDTH-1:0] selectedMap , mapAttack ,
    input enable , enableAttack ,

    output [DATA_WIDTH-1:0] matriz_data
);

mux2x1 muxMaps [DATA_WIDTH-1:0] (
        .in_a   (selectedMap) ,
        .in_b   (mapAttack) ,
        .select (enableAttack) ,
        .enable (enable) ,

        .out    (matriz_data)
    );
    
endmodule