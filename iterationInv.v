module iterationInv(in,subkey,out);
input [127:0] in;
input [127:0] subkey;
output [127:0] out;
wire [127:0] temp1;
wire [127:0] temp2;
wire [127:0] temp3;

InShiftRow ish(in,temp1);
SBoxInv isb(temp1,temp2);
AddRoundKey ar(temp2,subkey,temp3);
InMixColumns im(temp3,out);
		
endmodule
