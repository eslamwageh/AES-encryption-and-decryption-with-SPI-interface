module spi_master_test # (parameter Nk=4'b0100) 
(input Enable,
input wire miso,
input wire reset,
output wire mosi,
output reg LED,
input clock,
output reg ss,
output reg fin
);
reg [127:0] in;
reg[127+32*Nk:0]out;
reg [32*Nk-1:0] key;
reg [127+32*Nk:0] data_out;
reg [127+32*Nk:0] shift_reg;
reg done;
reg [2:0]state;
reg [8:0]bit_count;

//initial begin
//clock=1'b1;
//end
//always begin
//# 10 clock=~clock;
//end
parameter Idle=3'b000;
parameter Send=3'b001;
parameter WaitCipher=3'b010;
parameter WaitDecipher=3'b011;
parameter Receive = 3'b100;
parameter SendToDecryption=3'b101;
parameter ReceiveFromDecryption =3'b110;
parameter finish=3'b111;

initial begin
LED <= 1'b0;


in <=128'h00112233445566778899aabbccddeeff;

if (Nk == 4)
	key <=128'h000102030405060708090a0b0c0d0e0f;
else if (Nk == 6)
	key <=192'h000102030405060708090a0b0c0d0e0f1011121314151617;
else
	key <=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
end

always @(posedge clock) begin
if(reset)begin
	state <= Idle;
        bit_count <= 9'd0;
        shift_reg <= 0;
        ss <= 1'b0;
	done<=1'b0;
	LED <= 1'b0;
	fin<=1'b0;
//??? ????
end
else begin
case (state)
Idle:begin
if (Enable)
begin
	state<=Send;
	data_out[127+32*Nk:32*Nk] <= in;
	data_out[32*Nk-1:0]<=key;
        bit_count <= 9'd0;
        shift_reg <= 0;
		  fin<=1'b0;
end
end
Send : begin
	shift_reg <= {shift_reg[126+32*Nk:0], data_out[127+32*Nk]};
        data_out <= {data_out[126+32*Nk:0], data_out[127+32*Nk]};
        bit_count <= bit_count + 1;

	if (bit_count == 9'd128+32*Nk) begin
//$display("SR %h" , shift_reg);
		state<=WaitCipher;
		bit_count<=9'd0;
	end
end





WaitCipher : begin
	state<=Receive;
	bit_count<=9'd0;
end





WaitDecipher : begin
	state<=ReceiveFromDecryption;
	bit_count<=9'd0;
end




Receive:begin
//$display("bc %h" , bit_count);
shift_reg<={shift_reg[126+32*Nk:0],miso};
bit_count <= bit_count + 1;
if (bit_count > 9'd129+32*Nk) 
begin
//$display("SR %h" , shift_reg);
	data_out <= shift_reg;
        state <= SendToDecryption;
	//done<=1'b1;
        ss<=1'b1;
bit_count <= 9'd0;
        end

end
SendToDecryption:begin
//$display("bc %h" , bit_count);
//data_out<=out;//// the right hand side was    out
//$display("do %h" , data_out);
 shift_reg <= {shift_reg[126+32*Nk:0], data_out[127+32*Nk]};
        data_out <= {data_out[126+32*Nk:0], data_out[127+32*Nk]};
        bit_count <= bit_count + 1;
//ss<=1'b1;
if (bit_count == 9'd128+32*Nk) begin

//$display("SR %h" , shift_reg);
          state <= WaitDecipher;//edited (it was waitdecryption)
          bit_count <= 9'd0;
       
end
end

ReceiveFromDecryption:begin

shift_reg<={shift_reg[126+32 * Nk:0],miso};
bit_count <= bit_count + 1;
if (bit_count > 9'd128+32*Nk) 
begin
//$display("SR %h" , shift_reg);
//$display ("in = %h   key = %h" , in, key);
        //state <= Idle;//to be checked
	if (shift_reg == {in, key})
	begin
	//$display("SRR %h" , shift_reg);
	//$display ("in = %h   key = %h" , in, key);
		LED <= 1'b1;
	end
	fin<=1'b1;
	state <= finish;
	//done<=1'b1;
        //ss<=1'b1;
end
end
finish:
begin

end
endcase
end
end
always @(posedge clock) begin
  if (reset) begin
   out <= 0;
  end else begin
    if (done) begin
    out <= shift_reg[127+32*Nk:0] ;//shift_reg[127+32*Nk:0]           it was that
    end
	 
  end
end
assign mosi = shift_reg[0];

endmodule

