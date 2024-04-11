module MixColumns( input wire [127:0] data_in, output wire [127:0] data_out );
function [7:0]mb2;
input [7:0] s;
mb2= {s[6:0],1'b0}^ (8'h1b & {8{s[7]}});
endfunction
function [7:0]mb3;
input [7:0] s;
mb3= s^ mb2(s);
endfunction

assign data_out[127:120] = mb2(data_in[127:120])^mb3(data_in[119:112])^data_in[111:104]^data_in[103:96];
assign data_out[119:112] = data_in[127:120]^mb2(data_in[119:112])^mb3(data_in[111:104])^data_in[103:96];
assign data_out[111:104] = data_in[127:120]^data_in[119:112]^mb2(data_in[111:104])^mb3(data_in[103:96]);
assign data_out[103:96] = mb3(data_in[127:120])^data_in[119:112]^data_in[111:104]^mb2(data_in[103:96]);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign data_out[95:88] = mb2(data_in[95:88])^mb3(data_in[87:80])^data_in[79:72]^data_in[71:64];
assign data_out[87:80] = data_in[95:88]^mb2(data_in[87:80])^mb3(data_in[79:72])^data_in[71:64];
assign data_out[79:72] = data_in[95:88]^data_in[87:80]^mb2(data_in[79:72])^mb3(data_in[71:64]);
assign data_out[71:64] = mb3(data_in[95:88])^data_in[87:80]^data_in[79:72]^mb2(data_in[71:64]);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign data_out[63:56] = mb2(data_in[63:56])^mb3(data_in[55:48])^data_in[47:40]^data_in[39:32];
assign data_out[55:48] = data_in[63:56]^mb2(data_in[55:48])^mb3(data_in[47:40])^data_in[39:32];
assign data_out[47:40] = data_in[63:56]^data_in[55:48]^mb2(data_in[47:40])^mb3(data_in[39:32]);
assign data_out[39:32] = mb3(data_in[63:56])^data_in[55:48]^data_in[47:40]^mb2(data_in[39:32]);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign data_out[31:24] = mb2(data_in[31:24])^mb3(data_in[23:16])^data_in[15:8]^data_in[7:0];
assign data_out[23:16] = data_in[31:24]^mb2(data_in[23:16])^mb3(data_in[15:8])^data_in[7:0];
assign data_out[15:8] = data_in[31:24]^data_in[23:16]^mb2(data_in[15:8])^mb3(data_in[7:0]);
assign data_out[7:0] = mb3(data_in[31:24])^data_in[23:16]^data_in[15:8]^mb2(data_in[7:0]);

endmodule

