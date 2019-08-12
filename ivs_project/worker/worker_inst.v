	worker u0 (
		.clk_clk                  (<connected-to-clk_clk>),                  //        clk.clk
		.reset_reset_n            (<connected-to-reset_reset_n>),            //      reset.reset_n
		.worker_out_waitrequest   (<connected-to-worker_out_waitrequest>),   // worker_out.waitrequest
		.worker_out_readdata      (<connected-to-worker_out_readdata>),      //           .readdata
		.worker_out_readdatavalid (<connected-to-worker_out_readdatavalid>), //           .readdatavalid
		.worker_out_burstcount    (<connected-to-worker_out_burstcount>),    //           .burstcount
		.worker_out_writedata     (<connected-to-worker_out_writedata>),     //           .writedata
		.worker_out_address       (<connected-to-worker_out_address>),       //           .address
		.worker_out_write         (<connected-to-worker_out_write>),         //           .write
		.worker_out_read          (<connected-to-worker_out_read>),          //           .read
		.worker_out_byteenable    (<connected-to-worker_out_byteenable>),    //           .byteenable
		.worker_out_debugaccess   (<connected-to-worker_out_debugaccess>)    //           .debugaccess
	);

