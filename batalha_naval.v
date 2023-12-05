module batalha_naval (

    input [2:0] map_code , x_coord_code , y_coord_code , 
    input [1:0] game_state_code ,
    input confirmAttack , cpld_clk ,

    output [6:0] matriz_colune_data , display_colune_data ,
	output [4:0] matriz_colune_activator ,
    output [3:0] display_colune_activator ,


    output [100:0] teste ,

 );

    wire [34:0] selectedMap , mapAttack , matriz_data;
    wire [27:0] display_data;

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

    map_decoder map_decoder_1 (
        .map_code (map_code) ,
        .enable   (enable) , //mudar

        .mapOut   (selectedMap)
    ); //ativado tanto na preparação e no attack

    attack_round attack_round_1 (
        .selected_map  (selectedMap) ,
        .x_coord_code  (x_coord_code) ,
        .y_coord_code  (y_coord_code) ,
        .enable        (enableAttack) ,
        .confirmAttack (confirmAttack) ,

        .matriz_data   (mapAttack) ,
    );//ativado no ataque

    mux4x1 #(.DATA_WIDTH(35)) muxMaps (
        .in_a (selectedMap) ,
        .in_b (mapAttack) ,
        .select (enableAttack) ,
        .enable (enable) ,

        .out    (matriz_data)
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

    displayer segment_display (
        .clk              (clk) ,
        .image            (display_data) ,
        .enable           (enable) , //mudar

        .colune_activator (display_colune_activator) ,
        .colune_data      (display_colune_data)
    ); //ativado sempre



endmodule