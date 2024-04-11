module iteration(in,subkey,out);
input [127:0] in;
input [127:0] subkey;
output [127:0] out;

wire [127:0] temp1;
wire [127:0] temp2;
wire [127:0] temp3;
wire [127:0] temp4;

SBox a(in,temp1);
ShiftRow b(temp1,temp2);
MixColumns c(temp2,temp3);
AddRoundKey d(temp3,subkey,out);
		
endmodule