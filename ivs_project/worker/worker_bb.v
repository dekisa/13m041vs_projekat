
module worker (
	clk_clk,
	reset_reset_n,
	worker_out_waitrequest,
	worker_out_readdata,
	worker_out_readdatavalid,
	worker_out_burstcount,
	worker_out_writedata,
	worker_out_address,
	worker_out_write,
	worker_out_read,
	worker_out_byteenable,
	worker_out_debugaccess);	

	input		clk_clk;
	input		reset_reset_n;
	input		worker_out_waitrequest;
	input	[31:0]	worker_out_readdata;
	input		worker_out_readdatavalid;
	output	[0:0]	worker_out_burstcount;
	output	[31:0]	worker_out_writedata;
	output	[27:0]	worker_out_address;
	output		worker_out_write;
	output		worker_out_read;
	output	[3:0]	worker_out_byteenable;
	output		worker_out_debugaccess;
endmodule
