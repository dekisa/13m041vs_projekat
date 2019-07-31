	sdram u0 (
		.clk_clk             (<connected-to-clk_clk>),             //   clk.clk
		.reset_reset_n       (<connected-to-reset_reset_n>),       // reset.reset_n
		.sdram_addr          (<connected-to-sdram_addr>),          // sdram.addr
		.sdram_ba            (<connected-to-sdram_ba>),            //      .ba
		.sdram_cas_n         (<connected-to-sdram_cas_n>),         //      .cas_n
		.sdram_cke           (<connected-to-sdram_cke>),           //      .cke
		.sdram_cs_n          (<connected-to-sdram_cs_n>),          //      .cs_n
		.sdram_dq            (<connected-to-sdram_dq>),            //      .dq
		.sdram_dqm           (<connected-to-sdram_dqm>),           //      .dqm
		.sdram_ras_n         (<connected-to-sdram_ras_n>),         //      .ras_n
		.sdram_we_n          (<connected-to-sdram_we_n>),          //      .we_n
		.sdout_waitrequest   (<connected-to-sdout_waitrequest>),   // sdout.waitrequest
		.sdout_readdata      (<connected-to-sdout_readdata>),      //      .readdata
		.sdout_readdatavalid (<connected-to-sdout_readdatavalid>), //      .readdatavalid
		.sdout_burstcount    (<connected-to-sdout_burstcount>),    //      .burstcount
		.sdout_writedata     (<connected-to-sdout_writedata>),     //      .writedata
		.sdout_address       (<connected-to-sdout_address>),       //      .address
		.sdout_write         (<connected-to-sdout_write>),         //      .write
		.sdout_read          (<connected-to-sdout_read>),          //      .read
		.sdout_byteenable    (<connected-to-sdout_byteenable>),    //      .byteenable
		.sdout_debugaccess   (<connected-to-sdout_debugaccess>)    //      .debugaccess
	);

