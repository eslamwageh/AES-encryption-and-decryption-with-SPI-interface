module Cipher#(parameter nk = 8)(in, keyin, out);
input [0:127] in;
input [0:32 * nk - 1]keyin;
output [0:127] out;

wire [0: 128 *(nk + 7) - 1] win;
//reg [0: 128 *(nk + 7) - 1] w;
wire [0:127] temp1;
wire [0:127] temp2;
wire [0:127] temp3;

wire [127:0] temps [0:nk+5];



KeyExpansion#(nk)k(keyin, win);



AddRoundKey a(in, win[0:127], temps[0]);

genvar i;
generate
	
	
	//w = {w[128:128 *(nk + 7) - 1], win[0:127]};
	for (i = 1; i < nk + 6; i = i + 1)
	begin:hi

		iteration it(temps[i-1], win[128 * i: 128 * i + 127], temps[i]);
	end 
		SBox sb(temps[nk + 5], temp1);
		ShiftRow sr(temp1, temp2);
		AddRoundKey ad(temp2, win[128 *(nk + 6): 128 *(nk + 7) - 1], temp3);

assign out = temp3;
endgenerate
endmodule



