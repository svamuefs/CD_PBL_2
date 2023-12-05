module game_state_decoder (
    input [1:0] game_state_code ,
    output enablePreparation , enableAttack , enable
);

    //00 - off
    //01 - preparation
    //10 - attack
    //11 - preparation

    not not0 (notEnablePreparation , game_state_code[0]);
    and and0 (enablePreparation , game_state_code[0]);
    and and1 (enableAttack , game_state_code[1] , notEnablePreparation);

    or or0 (enable , enableAttack , enablePreparation);
    
endmodule