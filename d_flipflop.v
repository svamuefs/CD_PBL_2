module d_flipflop (
    input d , clk , reset , initial_value ,
    output reg out
);

	initial begin
		if (initial_value)
			out <= 1;
end

    always @(posedge clk or negedge reset) begin

        if (! reset)
            out <= 0;
        else 
            out <= d;

    end

endmodule