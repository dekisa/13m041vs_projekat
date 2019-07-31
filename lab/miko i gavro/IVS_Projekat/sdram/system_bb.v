
module system (
	clk_clk,
	reset_reset_n,
	sdram_clk_clk,
	wire_addr,
	wire_ba,
	wire_cas_n,
	wire_cke,
	wire_cs_n,
	wire_dq,
	wire_dqm,
	wire_ras_n,
	wire_we_n);	

	input		clk_clk;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	wire_addr;
	output	[1:0]	wire_ba;
	output		wire_cas_n;
	output		wire_cke;
	output		wire_cs_n;
	inout	[15:0]	wire_dq;
	output	[1:0]	wire_dqm;
	output		wire_ras_n;
	output		wire_we_n;
endmodule
