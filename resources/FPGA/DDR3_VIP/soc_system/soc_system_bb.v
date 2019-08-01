
module soc_system (
	alt_vip_cl_cvo_0_clocked_video_vid_clk,
	alt_vip_cl_cvo_0_clocked_video_vid_data,
	alt_vip_cl_cvo_0_clocked_video_underflow,
	alt_vip_cl_cvo_0_clocked_video_vid_datavalid,
	alt_vip_cl_cvo_0_clocked_video_vid_v_sync,
	alt_vip_cl_cvo_0_clocked_video_vid_h_sync,
	alt_vip_cl_cvo_0_clocked_video_vid_f,
	alt_vip_cl_cvo_0_clocked_video_vid_h,
	alt_vip_cl_cvo_0_clocked_video_vid_v,
	clk_clk,
	clk_hdmi_clk,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin);	

	input		alt_vip_cl_cvo_0_clocked_video_vid_clk;
	output	[23:0]	alt_vip_cl_cvo_0_clocked_video_vid_data;
	output		alt_vip_cl_cvo_0_clocked_video_underflow;
	output		alt_vip_cl_cvo_0_clocked_video_vid_datavalid;
	output		alt_vip_cl_cvo_0_clocked_video_vid_v_sync;
	output		alt_vip_cl_cvo_0_clocked_video_vid_h_sync;
	output		alt_vip_cl_cvo_0_clocked_video_vid_f;
	output		alt_vip_cl_cvo_0_clocked_video_vid_h;
	output		alt_vip_cl_cvo_0_clocked_video_vid_v;
	input		clk_clk;
	output		clk_hdmi_clk;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
endmodule
