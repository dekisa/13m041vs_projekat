
module sdram (
	clk_clk,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdout_waitrequest,
	sdout_readdata,
	sdout_readdatavalid,
	sdout_burstcount,
	sdout_writedata,
	sdout_address,
	sdout_write,
	sdout_read,
	sdout_byteenable,
	sdout_debugaccess);	

	input		clk_clk;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		sdout_waitrequest;
	output	[31:0]	sdout_readdata;
	output		sdout_readdatavalid;
	input	[0:0]	sdout_burstcount;
	input	[31:0]	sdout_writedata;
	input	[27:0]	sdout_address;
	input		sdout_write;
	input		sdout_read;
	input	[3:0]	sdout_byteenable;
	input		sdout_debugaccess;
endmodule
