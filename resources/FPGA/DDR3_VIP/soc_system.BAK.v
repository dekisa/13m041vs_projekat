// soc_system.v

// Generated using ACDS version 16.0 222

`timescale 1 ps / 1 ps
module soc_system (
		input  wire        alt_vip_cl_cvo_0_clocked_video_vid_clk,       // alt_vip_cl_cvo_0_clocked_video.vid_clk
		output wire [23:0] alt_vip_cl_cvo_0_clocked_video_vid_data,      //                               .vid_data
		output wire        alt_vip_cl_cvo_0_clocked_video_underflow,     //                               .underflow
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_datavalid, //                               .vid_datavalid
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_v_sync,    //                               .vid_v_sync
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_h_sync,    //                               .vid_h_sync
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_f,         //                               .vid_f
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_h,         //                               .vid_h
		output wire        alt_vip_cl_cvo_0_clocked_video_vid_v,         //                               .vid_v
		input  wire        clk_clk,                                      //                            clk.clk
		output wire        clk_hdmi_clk,                                 //                       clk_hdmi.clk
		output wire [14:0] memory_mem_a,                                 //                         memory.mem_a
		output wire [2:0]  memory_mem_ba,                                //                               .mem_ba
		output wire        memory_mem_ck,                                //                               .mem_ck
		output wire        memory_mem_ck_n,                              //                               .mem_ck_n
		output wire        memory_mem_cke,                               //                               .mem_cke
		output wire        memory_mem_cs_n,                              //                               .mem_cs_n
		output wire        memory_mem_ras_n,                             //                               .mem_ras_n
		output wire        memory_mem_cas_n,                             //                               .mem_cas_n
		output wire        memory_mem_we_n,                              //                               .mem_we_n
		output wire        memory_mem_reset_n,                           //                               .mem_reset_n
		inout  wire [31:0] memory_mem_dq,                                //                               .mem_dq
		inout  wire [3:0]  memory_mem_dqs,                               //                               .mem_dqs
		inout  wire [3:0]  memory_mem_dqs_n,                             //                               .mem_dqs_n
		output wire        memory_mem_odt,                               //                               .mem_odt
		output wire [3:0]  memory_mem_dm,                                //                               .mem_dm
		input  wire        memory_oct_rzqin                              //                               .oct_rzqin
	);

	wire          alt_vip_cl_vfb_0_dout_valid;                                // alt_vip_cl_vfb_0:dout_valid -> alt_vip_cl_cvo_0:din_valid
	wire   [23:0] alt_vip_cl_vfb_0_dout_data;                                 // alt_vip_cl_vfb_0:dout_data -> alt_vip_cl_cvo_0:din_data
	wire          alt_vip_cl_vfb_0_dout_ready;                                // alt_vip_cl_cvo_0:din_ready -> alt_vip_cl_vfb_0:dout_ready
	wire          alt_vip_cl_vfb_0_dout_startofpacket;                        // alt_vip_cl_vfb_0:dout_startofpacket -> alt_vip_cl_cvo_0:din_startofpacket
	wire          alt_vip_cl_vfb_0_dout_endofpacket;                          // alt_vip_cl_vfb_0:dout_endofpacket -> alt_vip_cl_cvo_0:din_endofpacket
	wire          alt_vip_cl_tpg_0_dout_valid;                                // alt_vip_cl_tpg_0:dout_valid -> alt_vip_cl_vfb_0:din_valid
	wire   [23:0] alt_vip_cl_tpg_0_dout_data;                                 // alt_vip_cl_tpg_0:dout_data -> alt_vip_cl_vfb_0:din_data
	wire          alt_vip_cl_tpg_0_dout_ready;                                // alt_vip_cl_vfb_0:din_ready -> alt_vip_cl_tpg_0:dout_ready
	wire          alt_vip_cl_tpg_0_dout_startofpacket;                        // alt_vip_cl_tpg_0:dout_startofpacket -> alt_vip_cl_vfb_0:din_startofpacket
	wire          alt_vip_cl_tpg_0_dout_endofpacket;                          // alt_vip_cl_tpg_0:dout_endofpacket -> alt_vip_cl_vfb_0:din_endofpacket
	wire          pll_0_outclk0_clk;                                          // pll_0:outclk_0 -> [alt_vip_cl_cvo_0:main_clock_clk, alt_vip_cl_tpg_0:main_clock, alt_vip_cl_vfb_0:main_clock, alt_vip_cl_vfb_0:mem_clock, ddr3_0:hps_f2h_sdram0_clock_clk, mm_interconnect_0:pll_0_outclk0_clk, rst_controller:clk, rst_controller_001:clk]
	wire          ddr3_0_h2f_reset_reset;                                     // ddr3_0:h2f_reset_reset_n -> [pll_0:rst, rst_controller:reset_in0, rst_controller_001:reset_in0]
	wire          alt_vip_cl_vfb_0_mem_master_rd_waitrequest;                 // mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_waitrequest -> alt_vip_cl_vfb_0:mem_master_rd_waitrequest
	wire  [127:0] alt_vip_cl_vfb_0_mem_master_rd_readdata;                    // mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_readdata -> alt_vip_cl_vfb_0:mem_master_rd_readdata
	wire   [31:0] alt_vip_cl_vfb_0_mem_master_rd_address;                     // alt_vip_cl_vfb_0:mem_master_rd_address -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_address
	wire          alt_vip_cl_vfb_0_mem_master_rd_read;                        // alt_vip_cl_vfb_0:mem_master_rd_read -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_read
	wire          alt_vip_cl_vfb_0_mem_master_rd_readdatavalid;               // mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_readdatavalid -> alt_vip_cl_vfb_0:mem_master_rd_readdatavalid
	wire    [5:0] alt_vip_cl_vfb_0_mem_master_rd_burstcount;                  // alt_vip_cl_vfb_0:mem_master_rd_burstcount -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_rd_burstcount
	wire          alt_vip_cl_vfb_0_mem_master_wr_waitrequest;                 // mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_waitrequest -> alt_vip_cl_vfb_0:mem_master_wr_waitrequest
	wire   [31:0] alt_vip_cl_vfb_0_mem_master_wr_address;                     // alt_vip_cl_vfb_0:mem_master_wr_address -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_address
	wire   [15:0] alt_vip_cl_vfb_0_mem_master_wr_byteenable;                  // alt_vip_cl_vfb_0:mem_master_wr_byteenable -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_byteenable
	wire          alt_vip_cl_vfb_0_mem_master_wr_write;                       // alt_vip_cl_vfb_0:mem_master_wr_write -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_write
	wire  [127:0] alt_vip_cl_vfb_0_mem_master_wr_writedata;                   // alt_vip_cl_vfb_0:mem_master_wr_writedata -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_writedata
	wire    [5:0] alt_vip_cl_vfb_0_mem_master_wr_burstcount;                  // alt_vip_cl_vfb_0:mem_master_wr_burstcount -> mm_interconnect_0:alt_vip_cl_vfb_0_mem_master_wr_burstcount
	wire  [127:0] mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdata;      // ddr3_0:hps_f2h_sdram0_data_readdata -> mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_readdata
	wire          mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_waitrequest;   // ddr3_0:hps_f2h_sdram0_data_waitrequest -> mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_waitrequest
	wire   [25:0] mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_address;       // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_address -> ddr3_0:hps_f2h_sdram0_data_address
	wire          mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_read;          // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_read -> ddr3_0:hps_f2h_sdram0_data_read
	wire   [15:0] mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_byteenable;    // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_byteenable -> ddr3_0:hps_f2h_sdram0_data_byteenable
	wire          mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdatavalid; // ddr3_0:hps_f2h_sdram0_data_readdatavalid -> mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_readdatavalid
	wire          mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_write;         // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_write -> ddr3_0:hps_f2h_sdram0_data_write
	wire  [127:0] mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_writedata;     // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_writedata -> ddr3_0:hps_f2h_sdram0_data_writedata
	wire    [8:0] mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_burstcount;    // mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_burstcount -> ddr3_0:hps_f2h_sdram0_data_burstcount
	wire          rst_controller_reset_out_reset;                             // rst_controller:reset_out -> [alt_vip_cl_cvo_0:main_reset_reset, alt_vip_cl_tpg_0:main_reset, alt_vip_cl_vfb_0:main_reset, alt_vip_cl_vfb_0:mem_reset, mm_interconnect_0:alt_vip_cl_vfb_0_mem_reset_reset_bridge_in_reset_reset]
	wire          rst_controller_001_reset_out_reset;                         // rst_controller_001:reset_out -> mm_interconnect_0:ddr3_0_hps_f2h_sdram0_data_translator_reset_reset_bridge_in_reset_reset

	soc_system_alt_vip_cl_cvo_0 #(
		.BPS                           (8),
		.NUMBER_OF_COLOUR_PLANES       (3),
		.COLOUR_PLANES_ARE_IN_PARALLEL (1),
		.INTERLACED                    (0),
		.H_ACTIVE_PIXELS               (1024),
		.V_ACTIVE_LINES                (768),
		.ACCEPT_COLOURS_IN_SEQ         (0),
		.FIFO_DEPTH                    (4000),
		.CLOCKS_ARE_SAME               (0),
		.USE_CONTROL                   (0),
		.NO_OF_MODES                   (1),
		.THRESHOLD                     (3999),
		.STD_WIDTH                     (1),
		.GENERATE_SYNC                 (0),
		.USE_EMBEDDED_SYNCS            (0),
		.AP_LINE                       (0),
		.V_BLANK                       (0),
		.H_BLANK                       (0),
		.H_SYNC_LENGTH                 (136),
		.H_FRONT_PORCH                 (24),
		.H_BACK_PORCH                  (160),
		.V_SYNC_LENGTH                 (6),
		.V_FRONT_PORCH                 (3),
		.V_BACK_PORCH                  (29),
		.F_RISING_EDGE                 (0),
		.F_FALLING_EDGE                (0),
		.FIELD0_V_RISING_EDGE          (0),
		.FIELD0_V_BLANK                (0),
		.FIELD0_V_SYNC_LENGTH          (0),
		.FIELD0_V_FRONT_PORCH          (0),
		.FIELD0_V_BACK_PORCH           (0),
		.ANC_LINE                      (0),
		.FIELD0_ANC_LINE               (0),
		.PIXELS_IN_PARALLEL            (1),
		.SRC_WIDTH                     (8),
		.DST_WIDTH                     (8),
		.CONTEXT_WIDTH                 (8),
		.TASK_WIDTH                    (8)
	) alt_vip_cl_cvo_0 (
		.clocked_video_vid_clk       (alt_vip_cl_cvo_0_clocked_video_vid_clk),       //     clocked_video.vid_clk
		.clocked_video_vid_data      (alt_vip_cl_cvo_0_clocked_video_vid_data),      //                  .vid_data
		.clocked_video_underflow     (alt_vip_cl_cvo_0_clocked_video_underflow),     //                  .underflow
		.clocked_video_vid_datavalid (alt_vip_cl_cvo_0_clocked_video_vid_datavalid), //                  .vid_datavalid
		.clocked_video_vid_v_sync    (alt_vip_cl_cvo_0_clocked_video_vid_v_sync),    //                  .vid_v_sync
		.clocked_video_vid_h_sync    (alt_vip_cl_cvo_0_clocked_video_vid_h_sync),    //                  .vid_h_sync
		.clocked_video_vid_f         (alt_vip_cl_cvo_0_clocked_video_vid_f),         //                  .vid_f
		.clocked_video_vid_h         (alt_vip_cl_cvo_0_clocked_video_vid_h),         //                  .vid_h
		.clocked_video_vid_v         (alt_vip_cl_cvo_0_clocked_video_vid_v),         //                  .vid_v
		.main_clock_clk              (pll_0_outclk0_clk),                            //        main_clock.clk
		.main_reset_reset            (rst_controller_reset_out_reset),               //        main_reset.reset
		.din_data                    (alt_vip_cl_vfb_0_dout_data),                   //               din.data
		.din_valid                   (alt_vip_cl_vfb_0_dout_valid),                  //                  .valid
		.din_startofpacket           (alt_vip_cl_vfb_0_dout_startofpacket),          //                  .startofpacket
		.din_endofpacket             (alt_vip_cl_vfb_0_dout_endofpacket),            //                  .endofpacket
		.din_ready                   (alt_vip_cl_vfb_0_dout_ready),                  //                  .ready
		.status_update_irq_irq       ()                                              // status_update_irq.irq
	);

	soc_system_alt_vip_cl_tpg_0 #(
		.BITS_PER_SYMBOL              (8),
		.COLOR_PLANES_ARE_IN_PARALLEL (1),
		.PIXELS_IN_PARALLEL           (1),
		.MAX_WIDTH                    (1024),
		.MAX_HEIGHT                   (768),
		.OUTPUT_FORMAT                ("4.4.4"),
		.COLOR_SPACE                  ("RGB"),
		.INTERLACING                  ("prog"),
		.PATTERN                      ("colorbars"),
		.UNIFORM_VALUE_RY             (16),
		.UNIFORM_VALUE_GCB            (16),
		.UNIFORM_VALUE_BCR            (16),
		.RUNTIME_CONTROL              (0)
	) alt_vip_cl_tpg_0 (
		.main_clock         (pll_0_outclk0_clk),                   // main_clock.clk
		.main_reset         (rst_controller_reset_out_reset),      // main_reset.reset
		.dout_data          (alt_vip_cl_tpg_0_dout_data),          //       dout.data
		.dout_valid         (alt_vip_cl_tpg_0_dout_valid),         //           .valid
		.dout_startofpacket (alt_vip_cl_tpg_0_dout_startofpacket), //           .startofpacket
		.dout_endofpacket   (alt_vip_cl_tpg_0_dout_endofpacket),   //           .endofpacket
		.dout_ready         (alt_vip_cl_tpg_0_dout_ready)          //           .ready
	);

	soc_system_alt_vip_cl_vfb_0 #(
		.BITS_PER_SYMBOL              (8),
		.NUMBER_OF_COLOR_PLANES       (3),
		.COLOR_PLANES_ARE_IN_PARALLEL (1),
		.PIXELS_IN_PARALLEL           (1),
		.READY_LATENCY                (1),
		.MAX_WIDTH                    (1024),
		.MAX_HEIGHT                   (768),
		.CLOCKS_ARE_SEPARATE          (1),
		.MEM_PORT_WIDTH               (128),
		.MEM_BASE_ADDR                (0),
		.BURST_ALIGNMENT              (1),
		.WRITE_FIFO_DEPTH             (512),
		.WRITE_BURST_TARGET           (32),
		.READ_FIFO_DEPTH              (512),
		.READ_BURST_TARGET            (32),
		.WRITER_RUNTIME_CONTROL       (0),
		.READER_RUNTIME_CONTROL       (0),
		.IS_FRAME_WRITER              (0),
		.IS_FRAME_READER              (0),
		.DROP_FRAMES                  (1),
		.REPEAT_FRAMES                (1),
		.DROP_REPEAT_USER             (0),
		.INTERLACED_SUPPORT           (0),
		.CONTROLLED_DROP_REPEAT       (0),
		.DROP_INVALID_FIELDS          (1),
		.MULTI_FRAME_DELAY            (1),
		.IS_SYNC_MASTER               (0),
		.IS_SYNC_SLAVE                (0),
		.USER_PACKETS_MAX_STORAGE     (1),
		.MAX_SYMBOLS_PER_PACKET       (10),
		.NUM_BUFFERS                  (3)
	) alt_vip_cl_vfb_0 (
		.main_clock                  (pll_0_outclk0_clk),                            //    main_clock.clk
		.main_reset                  (rst_controller_reset_out_reset),               //    main_reset.reset
		.mem_clock                   (pll_0_outclk0_clk),                            //     mem_clock.clk
		.mem_reset                   (rst_controller_reset_out_reset),               //     mem_reset.reset
		.din_data                    (alt_vip_cl_tpg_0_dout_data),                   //           din.data
		.din_valid                   (alt_vip_cl_tpg_0_dout_valid),                  //              .valid
		.din_startofpacket           (alt_vip_cl_tpg_0_dout_startofpacket),          //              .startofpacket
		.din_endofpacket             (alt_vip_cl_tpg_0_dout_endofpacket),            //              .endofpacket
		.din_ready                   (alt_vip_cl_tpg_0_dout_ready),                  //              .ready
		.mem_master_wr_address       (alt_vip_cl_vfb_0_mem_master_wr_address),       // mem_master_wr.address
		.mem_master_wr_burstcount    (alt_vip_cl_vfb_0_mem_master_wr_burstcount),    //              .burstcount
		.mem_master_wr_waitrequest   (alt_vip_cl_vfb_0_mem_master_wr_waitrequest),   //              .waitrequest
		.mem_master_wr_write         (alt_vip_cl_vfb_0_mem_master_wr_write),         //              .write
		.mem_master_wr_writedata     (alt_vip_cl_vfb_0_mem_master_wr_writedata),     //              .writedata
		.mem_master_wr_byteenable    (alt_vip_cl_vfb_0_mem_master_wr_byteenable),    //              .byteenable
		.dout_data                   (alt_vip_cl_vfb_0_dout_data),                   //          dout.data
		.dout_valid                  (alt_vip_cl_vfb_0_dout_valid),                  //              .valid
		.dout_startofpacket          (alt_vip_cl_vfb_0_dout_startofpacket),          //              .startofpacket
		.dout_endofpacket            (alt_vip_cl_vfb_0_dout_endofpacket),            //              .endofpacket
		.dout_ready                  (alt_vip_cl_vfb_0_dout_ready),                  //              .ready
		.mem_master_rd_address       (alt_vip_cl_vfb_0_mem_master_rd_address),       // mem_master_rd.address
		.mem_master_rd_burstcount    (alt_vip_cl_vfb_0_mem_master_rd_burstcount),    //              .burstcount
		.mem_master_rd_waitrequest   (alt_vip_cl_vfb_0_mem_master_rd_waitrequest),   //              .waitrequest
		.mem_master_rd_read          (alt_vip_cl_vfb_0_mem_master_rd_read),          //              .read
		.mem_master_rd_readdata      (alt_vip_cl_vfb_0_mem_master_rd_readdata),      //              .readdata
		.mem_master_rd_readdatavalid (alt_vip_cl_vfb_0_mem_master_rd_readdatavalid)  //              .readdatavalid
	);

	soc_system_ddr3_0 ddr3_0 (
		.clk_clk                           (clk_clk),                                                    //                  clk.clk
		.h2f_reset_reset_n                 (ddr3_0_h2f_reset_reset),                                     //            h2f_reset.reset_n
		.hps_f2h_sdram0_clock_clk          (pll_0_outclk0_clk),                                          // hps_f2h_sdram0_clock.clk
		.hps_f2h_sdram0_data_address       (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_address),       //  hps_f2h_sdram0_data.address
		.hps_f2h_sdram0_data_read          (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_read),          //                     .read
		.hps_f2h_sdram0_data_readdata      (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdata),      //                     .readdata
		.hps_f2h_sdram0_data_write         (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_write),         //                     .write
		.hps_f2h_sdram0_data_writedata     (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_writedata),     //                     .writedata
		.hps_f2h_sdram0_data_readdatavalid (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdatavalid), //                     .readdatavalid
		.hps_f2h_sdram0_data_waitrequest   (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_waitrequest),   //                     .waitrequest
		.hps_f2h_sdram0_data_byteenable    (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_byteenable),    //                     .byteenable
		.hps_f2h_sdram0_data_burstcount    (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_burstcount),    //                     .burstcount
		.memory_mem_a                      (memory_mem_a),                                               //               memory.mem_a
		.memory_mem_ba                     (memory_mem_ba),                                              //                     .mem_ba
		.memory_mem_ck                     (memory_mem_ck),                                              //                     .mem_ck
		.memory_mem_ck_n                   (memory_mem_ck_n),                                            //                     .mem_ck_n
		.memory_mem_cke                    (memory_mem_cke),                                             //                     .mem_cke
		.memory_mem_cs_n                   (memory_mem_cs_n),                                            //                     .mem_cs_n
		.memory_mem_ras_n                  (memory_mem_ras_n),                                           //                     .mem_ras_n
		.memory_mem_cas_n                  (memory_mem_cas_n),                                           //                     .mem_cas_n
		.memory_mem_we_n                   (memory_mem_we_n),                                            //                     .mem_we_n
		.memory_mem_reset_n                (memory_mem_reset_n),                                         //                     .mem_reset_n
		.memory_mem_dq                     (memory_mem_dq),                                              //                     .mem_dq
		.memory_mem_dqs                    (memory_mem_dqs),                                             //                     .mem_dqs
		.memory_mem_dqs_n                  (memory_mem_dqs_n),                                           //                     .mem_dqs_n
		.memory_mem_odt                    (memory_mem_odt),                                             //                     .mem_odt
		.memory_mem_dm                     (memory_mem_dm),                                              //                     .mem_dm
		.memory_oct_rzqin                  (memory_oct_rzqin)                                            //                     .oct_rzqin
	);

	soc_system_pll_0 pll_0 (
		.refclk   (clk_clk),                 //  refclk.clk
		.rst      (~ddr3_0_h2f_reset_reset), //   reset.reset
		.outclk_0 (pll_0_outclk0_clk),       // outclk0.clk
		.outclk_1 (clk_hdmi_clk),            // outclk1.clk
		.locked   ()                         // (terminated)
	);

	soc_system_mm_interconnect_0 mm_interconnect_0 (
		.pll_0_outclk0_clk                                                       (pll_0_outclk0_clk),                                          //                                                     pll_0_outclk0.clk
		.alt_vip_cl_vfb_0_mem_reset_reset_bridge_in_reset_reset                  (rst_controller_reset_out_reset),                             //                  alt_vip_cl_vfb_0_mem_reset_reset_bridge_in_reset.reset
		.ddr3_0_hps_f2h_sdram0_data_translator_reset_reset_bridge_in_reset_reset (rst_controller_001_reset_out_reset),                         // ddr3_0_hps_f2h_sdram0_data_translator_reset_reset_bridge_in_reset.reset
		.alt_vip_cl_vfb_0_mem_master_rd_address                                  (alt_vip_cl_vfb_0_mem_master_rd_address),                     //                                    alt_vip_cl_vfb_0_mem_master_rd.address
		.alt_vip_cl_vfb_0_mem_master_rd_waitrequest                              (alt_vip_cl_vfb_0_mem_master_rd_waitrequest),                 //                                                                  .waitrequest
		.alt_vip_cl_vfb_0_mem_master_rd_burstcount                               (alt_vip_cl_vfb_0_mem_master_rd_burstcount),                  //                                                                  .burstcount
		.alt_vip_cl_vfb_0_mem_master_rd_read                                     (alt_vip_cl_vfb_0_mem_master_rd_read),                        //                                                                  .read
		.alt_vip_cl_vfb_0_mem_master_rd_readdata                                 (alt_vip_cl_vfb_0_mem_master_rd_readdata),                    //                                                                  .readdata
		.alt_vip_cl_vfb_0_mem_master_rd_readdatavalid                            (alt_vip_cl_vfb_0_mem_master_rd_readdatavalid),               //                                                                  .readdatavalid
		.alt_vip_cl_vfb_0_mem_master_wr_address                                  (alt_vip_cl_vfb_0_mem_master_wr_address),                     //                                    alt_vip_cl_vfb_0_mem_master_wr.address
		.alt_vip_cl_vfb_0_mem_master_wr_waitrequest                              (alt_vip_cl_vfb_0_mem_master_wr_waitrequest),                 //                                                                  .waitrequest
		.alt_vip_cl_vfb_0_mem_master_wr_burstcount                               (alt_vip_cl_vfb_0_mem_master_wr_burstcount),                  //                                                                  .burstcount
		.alt_vip_cl_vfb_0_mem_master_wr_byteenable                               (alt_vip_cl_vfb_0_mem_master_wr_byteenable),                  //                                                                  .byteenable
		.alt_vip_cl_vfb_0_mem_master_wr_write                                    (alt_vip_cl_vfb_0_mem_master_wr_write),                       //                                                                  .write
		.alt_vip_cl_vfb_0_mem_master_wr_writedata                                (alt_vip_cl_vfb_0_mem_master_wr_writedata),                   //                                                                  .writedata
		.ddr3_0_hps_f2h_sdram0_data_address                                      (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_address),       //                                        ddr3_0_hps_f2h_sdram0_data.address
		.ddr3_0_hps_f2h_sdram0_data_write                                        (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_write),         //                                                                  .write
		.ddr3_0_hps_f2h_sdram0_data_read                                         (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_read),          //                                                                  .read
		.ddr3_0_hps_f2h_sdram0_data_readdata                                     (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdata),      //                                                                  .readdata
		.ddr3_0_hps_f2h_sdram0_data_writedata                                    (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_writedata),     //                                                                  .writedata
		.ddr3_0_hps_f2h_sdram0_data_burstcount                                   (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_burstcount),    //                                                                  .burstcount
		.ddr3_0_hps_f2h_sdram0_data_byteenable                                   (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_byteenable),    //                                                                  .byteenable
		.ddr3_0_hps_f2h_sdram0_data_readdatavalid                                (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_readdatavalid), //                                                                  .readdatavalid
		.ddr3_0_hps_f2h_sdram0_data_waitrequest                                  (mm_interconnect_0_ddr3_0_hps_f2h_sdram0_data_waitrequest)    //                                                                  .waitrequest
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~ddr3_0_h2f_reset_reset),        // reset_in0.reset
		.clk            (pll_0_outclk0_clk),              //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~ddr3_0_h2f_reset_reset),            // reset_in0.reset
		.clk            (pll_0_outclk0_clk),                  //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_req      (),                                   // (terminated)
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule