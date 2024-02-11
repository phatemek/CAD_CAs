module PE #(parameter N = 0, M = 127) (iregA, regB, addr, en, clk, rst, rstmac, cnt, enW, done);
	input [M:0] regB;
	input [31:0] iregA;
	input clk, rst, enW, done, en, rstmac;
	parameter L = (M == 127)?3:5;
	input [L:0] cnt;
	input [7:0] addr;
	wire [7:0] res;
	reg[31:0] DataMem[63:0];
	wire [1:0] remi;
	wire [M:0] regA;
	assign remi = 3 - addr[1:0];
	sreg16bit #(M) mysreg16(iregA, clk, rst, en, regA);
	mac #(M) mymac(regA, regB, clk, rst | rstmac, cnt, res);	
	reg [63:0] hex_char;
	integer j;
	always @(posedge clk) begin
		if (rst)begin
			for (j = 0; j < 64; j = j + 1) begin
				DataMem[j] = 32'b0;
			end
		end
		else if (enW) DataMem[addr >> 2][remi * 8 +: 8] = res;
	end
	integer i, DataMemFile;
	parameter tah = (M == 127)?43:25;
	always @(posedge done) begin
		if (M == 127) DataMemFile = $fopen($sformatf("./file/output%0d_L1.txt", N), "w");
   	 	else  DataMemFile = $fopen($sformatf("./file/output%0d_L2.txt", N), "w");
		for (i = 0; i < tah; i = i + 1) begin
      			$sformat(hex_char, "%h", DataMem[i]);
      			$fwrite(DataMemFile, "%s\n", hex_char);
    		end

    		$fclose(DataMemFile);
  	end
endmodule	
