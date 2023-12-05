module batalha_naval #(
    //matriz parameters
    parameter M_DATA_WIDTH = 35 ,
    M_COLUNE_SIZE = 7 ,
    M_TOTAL_COLUNES = 5 ,
    //display parameters
    D_DATA_WIDTH = 28 ,
    D_COLUNE_SIZE = 7 ,
    D_TOTAL_COLUNES = 4
    
)
(

    input [2:0] x_coord_code , y_coord_code , 
    input [1:0] game_state_code ,
    input nextMap , confirmAttack , cpld_clk ,

    output [6:0] matriz_colune_data , display_colune_data ,
	output [4:0] matriz_colune_activator ,
    output [3:0] display_colune_activator ,
    output [2:0] ledRgb ,


    output [100:0] teste 

 );

    wire [M_DATA_WIDTH-1:0] selectedMap , mapAttack , matriz_data;
    wire [D_DATA_WIDTH-1:0] display_data;
	 wire [2:0] map_code;

    // assign map = 35'b00000010000010000010000010000010000;
    // assign display_data = 28'b0000001000001000001000001000;
    // 0000001 0000010 0000100 0001000 0010000

    //testar demux, attack_round , game state decoder , colune display decoder , full display decoder
    //retirar comentarios no divisor
    //revisar attack_round , implementar debouncer para escolher o mapa, led rgb

    freq_div freq_div_1(
        .clk       (cpld_clk) , 

        .final_clk (clk)
    );

    game_state_decoder game_state_decoder_1 (
        .game_state_code   (game_state_code) , 

        .enablePreparation (enablePreparation) ,
        .enableAttack      (enableAttack) ,
        .enable            (enable)
    );

    debouncer debouncerNextMap (
        .button (nextMap) ,
        .clk    (clk) ,

        .out    (debouncedNextMap)
    );

    counter3bit counterMapCode(
        .clk   (debouncedNextMap) ,
        .reset (enable) ,

        .out   (map_code)
    );

    map_decoder map_decoder_1 (
        .map_code (map_code) ,
        .enable   (enable) , //mudar

        .mapOut   (selectedMap)
    ); //ativado tanto na preparação e no attack

    debouncer debouncerConfirmAttack (
        .button (confirmAttack),
        .clk    (clk) ,

        .out    (debouncedConfirmAttack)
    );

    attack_round attack_round_1 (
        .selected_map  (selectedMap) ,
        .x_coord_code  (x_coord_code) ,
        .y_coord_code  (y_coord_code) ,
        .enable        (enableAttack) ,
        .confirmAttack (debouncedConfirmAttack) ,

        .matriz_data   (mapAttack) ,
        .ledRgb        (ledRgb)
    );//ativado no ataque


    imageSelect imageSelect_1 (
        .selectedMap  (selectedMap) ,
        .mapAttack    (mapAttack) ,
        .enable       (enable) ,
        .enableAttack (enableAttack),

        .matriz_data  (matriz_data)
    );

    displayer matriz_displayer (
        .clk              (clk) , 
        .image            (matriz_data) ,
        .enable           (enable) , //mudar 

        .colune_activator (matriz_colune_activator) ,
        .colune_data      (matriz_colune_data)
    ); //ativado sempre, mas muda o que mostra baseado no status do jogo

    full_display_decoder full_display_decoder_1 (
        .status_code       (game_state_code) , 
        .x_coord_code      (x_coord_code) ,
        .y_coord_code      (y_coord_code) ,
        .enable            (enable) , 
        .enableAttack      (enableAttack) , 

        .display_data      (display_data)
    ); //ativado sempre, mas muda o que mostra baseado no status do jogo

    displayer #(.TOTAL_COLUNES(4)) segment_display (
        .clk              (clk) ,
        .image            (display_data) ,
        .enable           (enable) , //mudar

        .colune_activator (display_colune_activator) ,
        .colune_data      (display_colune_data)
    ); //ativado sempre



endmodule