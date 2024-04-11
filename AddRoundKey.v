module AddRoundKey (in,key,out);
input wire [0:127] in;
input wire [0:127] key;
output wire [0:127] out;
genvar i;
generate
for(i =0;i<127;i=i+8)
begin:hi
assign out[i:i+7]=in[i:i+7] ^ key[i:i+7];
end
endgenerate
endmodule
