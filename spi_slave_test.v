module spi_slave_test # (parameter Nk=4'b0100) 
(input Enable,
input wire mosi, 
input wire reset,
input clock,
input wire ss,
input fin,
output wire miso

);
reg [127:0] in;
wire [127:0] encryptionout;
wire [127:0] decryptionout;///
reg[127+32*Nk:0]out = 0;
reg [32*Nk-1:0] key;
reg [127+32*Nk:0] data_out;
reg [127+32*Nk:0] shift_reg;
reg [20:0] counter;
Cipher #(Nk) cipher_inst(in, key, encryptionout);
InvCipher #(Nk) inv_cipher_inst(in, key, decryptionout);
//reg done;
reg [2:0]state;
reg [8:0]bit_count;

//??? ????
parameter Idle=3'b000;
parameter Send=3'b001;
parameter Receive = 3'b010;
parameter WaitCipher=3'b011;
parameter WaitDecipher = 3'b100;
parameter finish=3'b101;
always @(posedge clock) begin
if(reset)begin
	state <= Idle;
        bit_count <= 9'd0;
        shift_reg <= 0;
		 
//done<=1'b0;
end
else begin
case (state)
Idle:begin
if (Enable)
begin
	state<=Receive;
	//data_out[127+32*Nk:32*Nk] <= in;
	//data_out[32*Nk-1:0]<=key;

	bit_count <= 9'd0;
	shift_reg <= 0;
end
end
Send : begin
if(fin==1'b1)
state<=finish;
$display("do %h  bc = %h" , data_out, bit_count);
 shift_reg <= {shift_reg[126+32*Nk:0], data_out[127+32*Nk]};   

        data_out <= {data_out[126+32*Nk:0], data_out[127+32*Nk]};
        bit_count <= bit_count + 1;
if (bit_count == 9'd128+32*Nk) begin//i edited it to test it should be the same as the rest of conditions
//$display("SR %h" , shift_reg);
state<=Receive;

bit_count<=9'd0;
end

end









Receive:begin : yes
if(fin==1'b1)
state<=finish;
shift_reg<={shift_reg[126+32*Nk:0],mosi};
bit_count <= bit_count + 1;
if (bit_count > 9'd128+32*Nk + ss) 
begin: yes
	//$display("SR %h" , shift_reg);
        in<=shift_reg[127+32*Nk:32*Nk];
	key<=shift_reg[32*Nk-1:0];
	//$display("SR %h" , shift_reg);
	//$display("in %h  key  %h" , in ,key);
	
	

	if (ss == 1'b0)
	begin
	state <= WaitCipher;
	end
	else
	begin
	//$display("SR %h" , shift_reg);
	//shift_reg <= {shift_reg[126+32*Nk:0], mosi};
	//in<=shift_reg[126+32*Nk:32*Nk-1];
	//key<={shift_reg[32*Nk-2:0],shift_reg[127+32*Nk]};
	//in<=shift_reg[126+32*Nk:32*Nk - 1];
	//key<={shift_reg[32*Nk-2:0], mosi};


	//$display("SR %h" , shift_reg);
	
	state <= WaitDecipher;
	//data_out[127+32*Nk:32*Nk] <= decryptionout;
	//$display ("in = %h   key = %h" , in, key);
	//$display("key %h" , key);
	//out <= shift_reg;
	end
	//data_out[32*Nk-1:0]<=key;/////////
	//$display("dooo %h" , data_out);
	bit_count<=9'd0;
	//done<=1'b1;
end
end






WaitCipher : begin
if(fin==1'b1)
state<=finish;
//$display("do %h  bc = %h" , data_out, bit_count);
data_out[127+32*Nk:32*Nk] <= encryptionout;  
data_out[32*Nk-1:0]<=key; 
//$display ("eo = %h   inn = %h" , encryptionout, in);
bit_count<=9'd0;
state<=Send;

end


WaitDecipher : begin
if(fin==1'b1)
state<=finish;
//$display("do %h  bc = %h" , data_out, bit_count);
data_out[127+32*Nk:32*Nk] <= decryptionout;  
data_out[32*Nk-1:0]<=key; 
//$display ("do = %h   inn = %h" , decryptionout, in);
bit_count<=9'd0;
state<=Send;

end
finish:begin
end



endcase
end
end

assign miso = shift_reg[0];

endmodule
