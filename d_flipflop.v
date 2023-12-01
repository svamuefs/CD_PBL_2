module d_flipflop (
    input d , clk , reset ,
    output reg out
);

    always @(negedge clk ) begin

        if (! reset)
            out <= 0;
        else 
            out <= d;

    end

endmodule