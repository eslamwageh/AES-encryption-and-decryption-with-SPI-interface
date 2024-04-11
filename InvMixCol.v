module InMixColumns(input wire[127:0] in, output wire[127:0] out);

function[7:0] multiplication2;
input[7:0] in;
multiplication2 = { in[6:0],1'b0}^(8'h1b& {8{in[7]}});
endfunction

function[7:0] multiplication9;
input[7:0] in;
multiplication9 = multiplication2(multiplication2(multiplication2(in))) ^ in;
endfunction


function[7:0] multiplicationb;
input[7:0] in;
multiplicationb = multiplication2(multiplication2(multiplication2(in)) ^ in) ^ in;
endfunction


function[7:0] multiplicationd;
input[7:0] in;
multiplicationd = multiplication2(multiplication2(multiplication2(in) ^ in)) ^ in;
endfunction


function[7:0] multiplicatione;
input[7:0] in;
multiplicatione = multiplication2(multiplication2(multiplication2(in) ^ in) ^ in);
endfunction




assign out[127:120] = multiplicatione(in[127:120]) ^ multiplicationb(in[119:112]) ^ multiplicationd(in[111:104]) ^ multiplication9(in[103:96]);
assign out[119:112] = multiplication9(in[127:120]) ^ multiplicatione(in[119:112]) ^ multiplicationb(in[111:104]) ^ multiplicationd(in[103:96]);
assign out[111:104] = multiplicationd(in[127:120]) ^ multiplication9(in[119:112]) ^ multiplicatione(in[111:104]) ^ multiplicationb(in[103:96]);
assign out[103:96] = multiplicationb(in[127:120]) ^ multiplicationd(in[119:112]) ^ multiplication9(in[111:104]) ^ multiplicatione(in[103:96]);



assign out[95:88] = multiplicatione(in[95:88]) ^ multiplicationb(in[87:80]) ^ multiplicationd(in[79:72]) ^ multiplication9(in[71:64]);
assign out[87:80] = multiplication9(in[95:88]) ^ multiplicatione(in[87:80]) ^ multiplicationb(in[79:72]) ^ multiplicationd(in[71:64]);
assign out[79:72] = multiplicationd(in[95:88]) ^ multiplication9(in[87:80]) ^ multiplicatione(in[79:72]) ^ multiplicationb(in[71:64]);
assign out[71:64] = multiplicationb(in[95:88]) ^ multiplicationd(in[87:80]) ^ multiplication9(in[79:72]) ^ multiplicatione(in[71:64]);


assign out[63:56] = multiplicatione(in[63:56]) ^ multiplicationb(in[55:48]) ^ multiplicationd(in[47:40]) ^ multiplication9(in[39:32]);
assign out[55:48] = multiplication9(in[63:56]) ^ multiplicatione(in[55:48]) ^ multiplicationb(in[47:40]) ^ multiplicationd(in[39:32]);
assign out[47:40] = multiplicationd(in[63:56]) ^ multiplication9(in[55:48]) ^ multiplicatione(in[47:40]) ^ multiplicationb(in[39:32]);
assign out[39:32] = multiplicationb(in[63:56]) ^ multiplicationd(in[55:48]) ^ multiplication9(in[47:40]) ^ multiplicatione(in[39:32]);


assign out[31:24] = multiplicatione(in[31:24]) ^ multiplicationb(in[23:16]) ^ multiplicationd(in[15:8]) ^ multiplication9(in[7:0]);
assign out[23:16] = multiplication9(in[31:24]) ^ multiplicatione(in[23:16]) ^ multiplicationb(in[15:8]) ^ multiplicationd(in[7:0]);
assign out[15:8] = multiplicationd(in[31:24]) ^ multiplication9(in[23:16]) ^ multiplicatione(in[15:8]) ^ multiplicationb(in[7:0]);
assign out[7:0] = multiplicationb(in[31:24]) ^ multiplicationd(in[23:16]) ^ multiplication9(in[15:8]) ^ multiplicatione(in[7:0]);




endmodule
