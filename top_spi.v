module top_spi(Enable,reset,clock,Nk,LED);

//input[1:0] nk;
input Enable;
input reset;
input clock;
input [3:0] Nk;
output reg LED;
wire Clk;
ClockDivider kb(clock,Clk);

wire miso1;
wire mosi1;
wire miso2;
wire mosi2;
wire miso3;
wire mosi3;
wire ss1;
wire ss2;
wire ss3;
wire LED1, LED2, LED3;
wire fin;
spi_master_test#(4) k(Enable,miso1,reset,mosi1,LED1,Clk,ss1,fin);
spi_slave_test#(4) sk(Enable,mosi1,reset,Clk,ss1,fin,miso1);

//spi_master_test#(6) k1(Enable,miso2,reset,mosi2,LED2,Clk,ss2);
//spi_slave_test#(6) sk1(Enable,mosi2,reset,Clk,ss2,miso2);

//spi_master_test#(8) k2(Enable,miso3,reset,mosi3,LED3,Clk,ss3);
//spi_slave_test#(8) sk2(Enable,mosi3,reset,Clk,ss3,miso3);




always@(*)
if (Nk == 4'b0100)
begin
	LED <= LED1;
end
else if (Nk == 4'b0110)
begin
	LED <= LED2;
end
else
begin
	LED <= LED3;
end
endmodule