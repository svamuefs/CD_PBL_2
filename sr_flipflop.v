module sr_flipflop (
    input s , r , reset , clk , 
    output reg out
);

    always @(posedge clk ) begin
        if (! reset)
            out <= 0;
        else 
            if (s && r)
                out <= 0;
                else
                    if (~(s || r))
                        out <= out;
                    else
                        if (s)
                            out <= 1;
                        else 
                            if (r)
                                out <= 0;
    end
    
endmodule