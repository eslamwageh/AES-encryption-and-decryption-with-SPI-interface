module InvCipher#(parameter nk = 4)(in,keyin, out);
input [0:127] in;
input [0:32 * nk - 1]keyin;
output [0:127] out;

wire [0: 128 *(nk + 7) - 1] win;
//reg [0: 128 *(nk + 7) - 1] w;
wire [0:127] temp1;
wire [0:127] temp2;
wire [0:127] temp3;

wire [127:0] temps [0:nk+5];

KeyExpansion #(nk) k (keyin, win);



genvar i;
generate
	
	AddRoundKey a(in, win[128 *(nk + 6) : 128 * (nk + 7) - 1], temps[nk+5]);
	
	for (i = nk + 4; i >= 0; i = i - 1)
	begin:hi

		iterationInv it(temps[i+1], win[128 * (i+1) : 128 * (i+1) + 127], temps[i]);
	end 
		InShiftRow ish(temps[0],temp1);
		SBoxInv isb(temp1,temp2);
		AddRoundKey ad(temp2, win[0:127], temp3);




endgenerate
assign out = temp3;

//always@(*)
//$display ("%h %h", in , out);

endmodule












