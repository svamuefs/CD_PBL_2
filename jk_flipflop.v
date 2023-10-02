module jk_flipflop (
    input j , k , reset , clk , 
    output reg out
);

    always @(posedge clk ) begin

        if (! reset)
            out <= 0;
        else 
            if (j && k)
                out <= ~out;
                else
                    if (~(j || k))
                        out <= out;
                    else
                        if (j)
                            out <= 1;
                        else 
                            if (k)
                                out <= 0;

    end
    
endmodule