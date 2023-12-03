module counter3bit (


    input clk , reset , down ,
    input [2:0] mod_value ,


    output loopStart , loopEnd ,
    output [2:0] out


);

    wire [2:0] tffOut;

    t_flipflop t_flipflop_0 (
		.clk (clk) ,
        .t (1) , 
        .reset (reset) , 
        .out (tff_out_1));

    not not1 (notTff1_w , tff_out_1);

    //up or down
    xor xor1 (tffOut[0] , tff_out_1 , down);
    //
    //Bit 0 out
    and andOut1 (out[0] , tffOut[0]);
    //
    t_flipflop t_flipflop_1 (
        .clk (tff_out_1) ,
        .t (1) , 
        .reset (reset) , 
        .out (tff_out_2));

    not not2 (notTff2_w , tff_out_2);

    xor xor2 (tffOut[1] , tff_out_2 , down);

    and andOut2 (out[1] , tffOut[1]);

    t_flipflop t_flipflop_2 (
        .clk (tff_out_2) ,
        .t (1) , 
        .reset (reset) , 
        .out (tff_out_3));

    not not3 (notTff3_w , tff_out_3);

    xor xor3 (tffOut[2] , tff_out_3 , down);

    and andOut3 (out[2] , tffOut[2]);

    //Mod - N Value

    wire [2:0] notModValue;

    not notMod1 [2:0] (notModValue , mod_value); //101 010

    xor xorMod1 (xorMod1_w , tffOut[0] , notModValue[0]);

    xor xorMod2 (xorMod2_w , tffOut[1] , notModValue[1]);

    xor xorMod3 (xorMod3_w , tffOut[2] , notModValue[2]);

    and andMod1 (loopEnd , xorMod1_w , xorMod2_w , xorMod3_w);

    //loopStart

    not notDown (up , down);

    and andLoopStart_1 (loopStartUp , notTff1_w , notTff2_w , notTff3_w , up);
    and andLoopStart_2 (loopStartDown , tffOut[0] , tffOut[1] , tffOut[2] , down);

    or orLoopStart_1 (loopStart , loopStartUp , loopStartDown); 

endmodule