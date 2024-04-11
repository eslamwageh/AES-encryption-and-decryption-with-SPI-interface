module KeyExpansion#(parameter nk = 4)(keyin, wo);
output reg[0: 128 *(nk + 7) - 1]  wo;
reg [0: 128 *(nk + 7) - 1] w;
input [0:32 * nk - 1]keyin;
//assign w[0:32 * nk - 1] = key;
reg [0:31] RotWordout;
reg[0:31]temp;// represents a word
reg[0:32 * nk - 1]key;
reg[0:31]SubWordout;
reg[0:31]SubWordout2;
reg[0:31]Rconout;
reg[0:31]temp2;
reg[0:31]temp3;
reg[0:31]temp4;

function [0:31] Rcon;
input [0:6] i;
input [0:3] nk;

begin
	Rcon = 
(i / nk == 1) ? 32'h01000000:
(i / nk == 2) ? 32'h02000000:
(i / nk == 3) ? 32'h04000000:
(i / nk == 4) ? 32'h08000000:
(i / nk == 5) ? 32'h10000000:
(i / nk == 6) ? 32'h20000000:
(i / nk == 7) ? 32'h40000000:
(i / nk == 8) ? 32'h80000000:
(i / nk == 9) ? 32'h1b000000:
(i / nk == 10) ? 32'h36000000:
32'bx;
end
endfunction


function [0:31] SubWord;
input [0:31] in;

begin :yes

	integer i;
	for (i = 0; i < 32; i = i + 8)
	begin
		SubWord[0:7] = SubByte (in[0:7]);
		SubWord = {SubWord[8:31] , SubWord[0:7]};
		in = {in[8:31] , in[0:7]};
	end
end
endfunction

//32 * nk












function [0:31] RotWord;
input [0:31] in;

begin

	RotWord = {in[8:31], in[0:7]};

end

endfunction



function [0:7] SubByte;
input [0:7] in;

begin

SubByte = 
(in == 8'b00000000) ? 8'b0110_0011:
(in == 8'b00000001) ? 8'b0111_1100:
(in == 8'b00000010) ? 8'b0111_0111:
(in == 8'b00000011) ? 8'b0111_1011:
(in == 8'b00000100) ? 8'b1111_0010:
(in == 8'b00000101) ? 8'b0110_1011:
(in == 8'b00000110) ? 8'b0110_1111:
(in == 8'b00000111) ? 8'b1100_0101:
(in == 8'b00001000) ? 8'b0011_0000:
(in == 8'b00001001) ? 8'b0000_0001:
(in == 8'b00001010) ? 8'b0110_0111:
(in == 8'b00001011) ? 8'b0010_1011:
(in == 8'b00001100) ? 8'b1111_1110:
(in == 8'b00001101) ? 8'b1101_0111:
(in == 8'b00001110) ? 8'b1010_1011:
(in == 8'b00001111) ? 8'b0111_0110:

(in == 8'b00010000) ? 8'b1100_1010:
(in == 8'b00010001) ? 8'b1000_0010:
(in == 8'b00010010) ? 8'b1100_1001:
(in == 8'b00010011) ? 8'b0111_1101:
(in == 8'b00010100) ? 8'b1111_1010:
(in == 8'b00010101) ? 8'b0101_1001:
(in == 8'b00010110) ? 8'b0100_0111:
(in == 8'b00010111) ? 8'b1111_0000:
(in == 8'b00011000) ? 8'b1010_1101:
(in == 8'b00011001) ? 8'b1101_0100:
(in == 8'b00011010) ? 8'b1010_0010:
(in == 8'b00011011) ? 8'b1010_1111:
(in == 8'b00011100) ? 8'b1001_1100:
(in == 8'b00011101) ? 8'b1010_0100:
(in == 8'b00011110) ? 8'b0111_0010:
(in == 8'b00011111) ? 8'b1100_0000:

(in == 8'b00100000) ? 8'b1011_0111:
(in == 8'b00100001) ? 8'b1111_1101:
(in == 8'b00100010) ? 8'b1001_0011:
(in == 8'b00100011) ? 8'b0010_0110:
(in == 8'b00100100) ? 8'b0011_0110:
(in == 8'b00100101) ? 8'b0011_1111:
(in == 8'b00100110) ? 8'b1111_0111:
(in == 8'b00100111) ? 8'b1100_1100:
(in == 8'b00101000) ? 8'b0011_0100:
(in == 8'b00101001) ? 8'b1010_0101:
(in == 8'b00101010) ? 8'b1110_0101:
(in == 8'b00101011) ? 8'b1111_0001:
(in == 8'b00101100) ? 8'b0111_0001:
(in == 8'b00101101) ? 8'b1101_1000:
(in == 8'b00101110) ? 8'b0011_0001:
(in == 8'b00101111) ? 8'b0001_0101:

(in == 8'b00110000) ? 8'b0000_0100:
(in == 8'b00110001) ? 8'b1100_0111:
(in == 8'b00110010) ? 8'b0010_0011:
(in == 8'b00110011) ? 8'b1100_0011:
(in == 8'b00110100) ? 8'b0001_1000:
(in == 8'b00110101) ? 8'b1001_0110:
(in == 8'b00110110) ? 8'b0000_0101:
(in == 8'b00110111) ? 8'b1001_1010:
(in == 8'b00111000) ? 8'b0000_0111:
(in == 8'b00111001) ? 8'b0001_0010:
(in == 8'b00111010) ? 8'b1000_0000:
(in == 8'b00111011) ? 8'b1110_0010:
(in == 8'b00111100) ? 8'b1110_1011:
(in == 8'b00111101) ? 8'b0010_0111:
(in == 8'b00111110) ? 8'b1011_0010:
(in == 8'b00111111) ? 8'b0111_0101:

(in == 8'b01000000) ? 8'b0000_1001:
(in == 8'b01000001) ? 8'b1000_0011:
(in == 8'b01000010) ? 8'b0010_1100:
(in == 8'b01000011) ? 8'b0001_1010:
(in == 8'b01000100) ? 8'b0001_1011:
(in == 8'b01000101) ? 8'b0110_1110:
(in == 8'b01000110) ? 8'b0101_1010:
(in == 8'b01000111) ? 8'b1010_0000:
(in == 8'b01001000) ? 8'b0101_0010:
(in == 8'b01001001) ? 8'b0011_1011:
(in == 8'b01001010) ? 8'b1101_0110:
(in == 8'b01001011) ? 8'b1011_0011:
(in == 8'b01001100) ? 8'b0010_1001:
(in == 8'b01001101) ? 8'b1110_0011:
(in == 8'b01001110) ? 8'b0010_1111:
(in == 8'b01001111) ? 8'b1000_0100:

(in == 8'b01010000) ? 8'b0101_0011:
(in == 8'b01010001) ? 8'b1101_0001:
(in == 8'b01010010) ? 8'b0000_0000:
(in == 8'b01010011) ? 8'b1110_1101:
(in == 8'b01010100) ? 8'b0010_0000:
(in == 8'b01010101) ? 8'b1111_1100:
(in == 8'b01010110) ? 8'b1011_0001:
(in == 8'b01010111) ? 8'b0101_1011:
(in == 8'b01011000) ? 8'b0110_1010:
(in == 8'b01011001) ? 8'b1100_1011:
(in == 8'b01011010) ? 8'b1011_1110:
(in == 8'b01011011) ? 8'b0011_1001:
(in == 8'b01011100) ? 8'b0100_1010:
(in == 8'b01011101) ? 8'b0100_1100:
(in == 8'b01011110) ? 8'b0101_1000:
(in == 8'b01011111) ? 8'b1100_1111:

(in == 8'b01100000) ? 8'b1101_0000:
(in == 8'b01100001) ? 8'b1110_1111:
(in == 8'b01100010) ? 8'b1010_1010:
(in == 8'b01100011) ? 8'b1111_1011:
(in == 8'b01100100) ? 8'b0100_0011:
(in == 8'b01100101) ? 8'b0100_1101:
(in == 8'b01100110) ? 8'b0011_0011:
(in == 8'b01100111) ? 8'b1000_0101:
(in == 8'b01101000) ? 8'b0100_0101:
(in == 8'b01101001) ? 8'b1111_1001:
(in == 8'b01101010) ? 8'b0000_0010:
(in == 8'b01101011) ? 8'b0111_1111:
(in == 8'b01101100) ? 8'b0101_0000:
(in == 8'b01101101) ? 8'b0011_1100:
(in == 8'b01101110) ? 8'b1001_1111:
(in == 8'b01101111) ? 8'b1010_1000:

(in == 8'b01110000) ? 8'b0101_0001:
(in == 8'b01110001) ? 8'b1010_0011:
(in == 8'b01110010) ? 8'b0100_0000:
(in == 8'b01110011) ? 8'b1000_1111:
(in == 8'b01110100) ? 8'b1001_0010:
(in == 8'b01110101) ? 8'b1001_1101:
(in == 8'b01110110) ? 8'b0011_1000:
(in == 8'b01110111) ? 8'b1111_0101:
(in == 8'b01111000) ? 8'b1011_1100:
(in == 8'b01111001) ? 8'b1011_0110:
(in == 8'b01111010) ? 8'b1101_1010:
(in == 8'b01111011) ? 8'b0010_0001:
(in == 8'b01111100) ? 8'b0001_0000:
(in == 8'b01111101) ? 8'b1111_1111:
(in == 8'b01111110) ? 8'b1111_0011:
(in == 8'b01111111) ? 8'b1101_0010:

(in == 8'b10000000) ? 8'b1100_1101:
(in == 8'b10000001) ? 8'b0000_1100:
(in == 8'b10000010) ? 8'b0001_0011:
(in == 8'b10000011) ? 8'b1110_1100:
(in == 8'b10000100) ? 8'b0101_1111:
(in == 8'b10000101) ? 8'b1001_0111:
(in == 8'b10000110) ? 8'b0100_0100:
(in == 8'b10000111) ? 8'b0001_0111:
(in == 8'b10001000) ? 8'b1100_0100:
(in == 8'b10001001) ? 8'b1010_0111:
(in == 8'b10001010) ? 8'b0111_1110:
(in == 8'b10001011) ? 8'b0011_1101:
(in == 8'b10001100) ? 8'b0110_0100:
(in == 8'b10001101) ? 8'b0101_1101:
(in == 8'b10001110) ? 8'b0001_1001:
(in == 8'b10001111) ? 8'b0111_0011:

(in == 8'b10010000) ? 8'b0110_0000:
(in == 8'b10010001) ? 8'b1000_0001:
(in == 8'b10010010) ? 8'b0100_1111:
(in == 8'b10010011) ? 8'b1101_1100:
(in == 8'b10010100) ? 8'b0010_0010:
(in == 8'b10010101) ? 8'b0010_1010:
(in == 8'b10010110) ? 8'b1001_0000:
(in == 8'b10010111) ? 8'b1000_1000:
(in == 8'b10011000) ? 8'b0100_0110:
(in == 8'b10011001) ? 8'b1110_1110:
(in == 8'b10011010) ? 8'b1011_1000:
(in == 8'b10011011) ? 8'b0001_0100:
(in == 8'b10011100) ? 8'b1101_1110:
(in == 8'b10011101) ? 8'b0101_1110:
(in == 8'b10011110) ? 8'b0000_1011:
(in == 8'b10011111) ? 8'b1101_1011:

(in == 8'b10100000) ? 8'b1110_0000:
(in == 8'b10100001) ? 8'b0011_0010:
(in == 8'b10100010) ? 8'b0011_1010:
(in == 8'b10100011) ? 8'b0000_1010:
(in == 8'b10100100) ? 8'b0100_1001:
(in == 8'b10100101) ? 8'b0000_0110:
(in == 8'b10100110) ? 8'b0010_0100:
(in == 8'b10100111) ? 8'b0101_1100:
(in == 8'b10101000) ? 8'b1100_0010:
(in == 8'b10101001) ? 8'b1101_0011:
(in == 8'b10101010) ? 8'b1010_1100:
(in == 8'b10101011) ? 8'b0110_0010:
(in == 8'b10101100) ? 8'b1001_0001:
(in == 8'b10101101) ? 8'b1001_0101:
(in == 8'b10101110) ? 8'b1110_0100:
(in == 8'b10101111) ? 8'b0111_1001:

(in == 8'b10110000) ? 8'b1110_0111:
(in == 8'b10110001) ? 8'b1100_1000:
(in == 8'b10110010) ? 8'b0011_0111:
(in == 8'b10110011) ? 8'b0110_1101:
(in == 8'b10110100) ? 8'b1000_1101:
(in == 8'b10110101) ? 8'b1101_0101:
(in == 8'b10110110) ? 8'b0100_1110:
(in == 8'b10110111) ? 8'b1010_1001:
(in == 8'b10111000) ? 8'b0110_1100:
(in == 8'b10111001) ? 8'b0101_0110:
(in == 8'b10111010) ? 8'b1111_0100:
(in == 8'b10111011) ? 8'b1110_1010:
(in == 8'b10111100) ? 8'b0110_0101:
(in == 8'b10111101) ? 8'b0111_1010:
(in == 8'b10111110) ? 8'b1010_1110:
(in == 8'b10111111) ? 8'b0000_1000:

(in == 8'b11000000) ? 8'b1011_1010:
(in == 8'b11000001) ? 8'b0111_1000:
(in == 8'b11000010) ? 8'b0010_0101:
(in == 8'b11000011) ? 8'b0010_1110:
(in == 8'b11000100) ? 8'b0001_1100:
(in == 8'b11000101) ? 8'b1010_0110:
(in == 8'b11000110) ? 8'b1011_0100:
(in == 8'b11000111) ? 8'b1100_0110:
(in == 8'b11001000) ? 8'b1110_1000:
(in == 8'b11001001) ? 8'b1101_1101:
(in == 8'b11001010) ? 8'b0111_0100:
(in == 8'b11001011) ? 8'b0001_1111:
(in == 8'b11001100) ? 8'b0100_1011:
(in == 8'b11001101) ? 8'b1011_1101:
(in == 8'b11001110) ? 8'b1000_1011:
(in == 8'b11001111) ? 8'b1000_1010:

(in == 8'b11010000) ? 8'b0111_0000:
(in == 8'b11010001) ? 8'b0011_1110:
(in == 8'b11010010) ? 8'b1011_0101:
(in == 8'b11010011) ? 8'b0110_0110:
(in == 8'b11010100) ? 8'b0100_1000:
(in == 8'b11010101) ? 8'b0000_0011:
(in == 8'b11010110) ? 8'b1111_0110:
(in == 8'b11010111) ? 8'b0000_1110:
(in == 8'b11011000) ? 8'b0110_0001:
(in == 8'b11011001) ? 8'b0011_0101:
(in == 8'b11011010) ? 8'b0101_0111:
(in == 8'b11011011) ? 8'b1011_1001:
(in == 8'b11011100) ? 8'b1000_0110:
(in == 8'b11011101) ? 8'b1100_0001:
(in == 8'b11011110) ? 8'b0001_1101:
(in == 8'b11011111) ? 8'b1001_1110:

(in == 8'b11100000) ? 8'b1110_0001:
(in == 8'b11100001) ? 8'b1111_1000:
(in == 8'b11100010) ? 8'b1001_1000:
(in == 8'b11100011) ? 8'b0001_0001:
(in == 8'b11100100) ? 8'b0110_1001:
(in == 8'b11100101) ? 8'b1101_1001:
(in == 8'b11100110) ? 8'b1000_1110:
(in == 8'b11100111) ? 8'b1001_0100:
(in == 8'b11101000) ? 8'b1001_1011:
(in == 8'b11101001) ? 8'b0001_1110:
(in == 8'b11101010) ? 8'b1000_0111:
(in == 8'b11101011) ? 8'b1110_1001:
(in == 8'b11101100) ? 8'b1100_1110:
(in == 8'b11101101) ? 8'b0101_0101:
(in == 8'b11101110) ? 8'b0010_1000:
(in == 8'b11101111) ? 8'b1101_1111:

(in == 8'b11110000) ? 8'b1000_1100:
(in == 8'b11110001) ? 8'b1010_0001:
(in == 8'b11110010) ? 8'b1000_1001:
(in == 8'b11110011) ? 8'b0000_1101:
(in == 8'b11110100) ? 8'b1011_1111:
(in == 8'b11110101) ? 8'b1110_0110:
(in == 8'b11110110) ? 8'b0100_0010:
(in == 8'b11110111) ? 8'b0110_1000:
(in == 8'b11111000) ? 8'b0100_0001:
(in == 8'b11111001) ? 8'b1001_1001:
(in == 8'b11111010) ? 8'b0010_1101:
(in == 8'b11111011) ? 8'b0000_1111:
(in == 8'b11111100) ? 8'b1011_0000:
(in == 8'b11111101) ? 8'b0101_0100:
(in == 8'b11111110) ? 8'b1011_1011:
(in == 8'b11111111) ? 8'b0001_0110:

8'bxxxxxxxx;

end
endfunction




integer i;

always@(keyin)
begin 
key = keyin;	

for(i = 0; i < 4 * (nk + 7); i = i + 1)
begin
	if (i < nk)
	begin
		w[0:31] = key[0:31];
		w = {w[32:128 *(nk + 7) - 1],w[0:31]};
		key = {key[32:32*nk - 1],key[0:31]};
	end
	else
	begin
		temp = w[128 *(nk + 7) - 32 : 128 *(nk + 7) - 1];
		if (i % nk == 0)
		begin	  
		  RotWordout = RotWord (temp);
		  SubWordout = SubWord (RotWordout);
		  Rconout = Rcon(i,nk);
		  temp2 = SubWordout ^  Rconout;
		  w[0:31] = w[128 *(nk + 7) - (32 * nk) : 128 *(nk + 7) - (32 * nk) + 31] ^ temp2;
		  w = {w[32 : 128 *(nk + 7) - 1], w[0:31]};
		end
		else if (nk > 6 && (i % nk == 4))
		begin
		  SubWordout2 = SubWord (temp);
		  temp3 = SubWordout2;
		  w[0:31] = w[128 *(nk + 7) - (32 * nk) : 128 *(nk + 7) - (32 * nk) + 31] ^ temp3;
		  w = {w[32 : 128 *(nk + 7) - 1], w[0:31]};
		end
		else
		begin
		w[0:31] = w[128 *(nk + 7) - (32 * nk) : 128 *(nk + 7) - (32 * nk) + 31] ^ temp;
		w = {w[32 : 128 *(nk + 7) - 1], w[0:31]};
		end
	end
end

end

always @(*)
wo <= w;

endmodule










