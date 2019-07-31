
module worker (
	clk_clk,
	reset_reset_n,
	wout_waitrequest,
	wout_readdata,
	wout_readdatavalid,
	wout_burstcount,
	wout_writedata,
	wout_address,
	wout_write,
	wout_read,
	wout_byteenable,
	wout_debugaccess);	

	input		clk_clk;
	input		reset_reset_n;
	input		wout_waitrequest;
	input	[31:0]	wout_readdata;
	input		wout_readdatavalid;
	output	[0:0]	wout_burstcount;
	output	[31:0]	wout_writedata;
	output	[27:0]	wout_address;
	output		wout_write;
	output		wout_read;
	output	[3:0]	wout_byteenable;
	output		wout_debugaccess;
endmodule
