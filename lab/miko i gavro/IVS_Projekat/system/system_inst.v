	system u0 (
		.clk_clk       (<connected-to-clk_clk>),       //       clk.clk
		.reset_reset_n (<connected-to-reset_reset_n>), //     reset.reset_n
		.sdram_clk_clk (<connected-to-sdram_clk_clk>), // sdram_clk.clk
		.wire_addr     (<connected-to-wire_addr>),     //      wire.addr
		.wire_ba       (<connected-to-wire_ba>),       //          .ba
		.wire_cas_n    (<connected-to-wire_cas_n>),    //          .cas_n
		.wire_cke      (<connected-to-wire_cke>),      //          .cke
		.wire_cs_n     (<connected-to-wire_cs_n>),     //          .cs_n
		.wire_dq       (<connected-to-wire_dq>),       //          .dq
		.wire_dqm      (<connected-to-wire_dqm>),      //          .dqm
		.wire_ras_n    (<connected-to-wire_ras_n>),    //          .ras_n
		.wire_we_n     (<connected-to-wire_we_n>)      //          .we_n
	);

