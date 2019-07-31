	worker u0 (
		.clk_clk            (<connected-to-clk_clk>),            //   clk.clk
		.reset_reset_n      (<connected-to-reset_reset_n>),      // reset.reset_n
		.wout_waitrequest   (<connected-to-wout_waitrequest>),   //  wout.waitrequest
		.wout_readdata      (<connected-to-wout_readdata>),      //      .readdata
		.wout_readdatavalid (<connected-to-wout_readdatavalid>), //      .readdatavalid
		.wout_burstcount    (<connected-to-wout_burstcount>),    //      .burstcount
		.wout_writedata     (<connected-to-wout_writedata>),     //      .writedata
		.wout_address       (<connected-to-wout_address>),       //      .address
		.wout_write         (<connected-to-wout_write>),         //      .write
		.wout_read          (<connected-to-wout_read>),          //      .read
		.wout_byteenable    (<connected-to-wout_byteenable>),    //      .byteenable
		.wout_debugaccess   (<connected-to-wout_debugaccess>)    //      .debugaccess
	);

