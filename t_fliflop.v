module t_flipflop (
    input t , clk , reset ,
    output reg out
);

    always @(posedge clk ) begin

        if (! reset)
            out <=0;
        else 
            if (t)
                out <= ~out;
            else
                out <= out;
    end

    
endmodule