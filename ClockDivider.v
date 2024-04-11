module ClockDivider (
    input clk,
    output reg clk_div
    );
reg [3:0] count=4'b0000;
always @ (posedge clk)
begin

    count<=count+1;
     clk_div <= count[0];
end
endmodule