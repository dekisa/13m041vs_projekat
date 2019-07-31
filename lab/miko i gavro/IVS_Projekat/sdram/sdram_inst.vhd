	component sdram is
		port (
			clk_clk             : in    std_logic                     := 'X';             -- clk
			reset_reset_n       : in    std_logic                     := 'X';             -- reset_n
			sdram_addr          : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba            : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n         : out   std_logic;                                        -- cas_n
			sdram_cke           : out   std_logic;                                        -- cke
			sdram_cs_n          : out   std_logic;                                        -- cs_n
			sdram_dq            : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm           : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n         : out   std_logic;                                        -- ras_n
			sdram_we_n          : out   std_logic;                                        -- we_n
			sdout_waitrequest   : out   std_logic;                                        -- waitrequest
			sdout_readdata      : out   std_logic_vector(31 downto 0);                    -- readdata
			sdout_readdatavalid : out   std_logic;                                        -- readdatavalid
			sdout_burstcount    : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			sdout_writedata     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			sdout_address       : in    std_logic_vector(27 downto 0) := (others => 'X'); -- address
			sdout_write         : in    std_logic                     := 'X';             -- write
			sdout_read          : in    std_logic                     := 'X';             -- read
			sdout_byteenable    : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			sdout_debugaccess   : in    std_logic                     := 'X'              -- debugaccess
		);
	end component sdram;

	u0 : component sdram
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --   clk.clk
			reset_reset_n       => CONNECTED_TO_reset_reset_n,       -- reset.reset_n
			sdram_addr          => CONNECTED_TO_sdram_addr,          -- sdram.addr
			sdram_ba            => CONNECTED_TO_sdram_ba,            --      .ba
			sdram_cas_n         => CONNECTED_TO_sdram_cas_n,         --      .cas_n
			sdram_cke           => CONNECTED_TO_sdram_cke,           --      .cke
			sdram_cs_n          => CONNECTED_TO_sdram_cs_n,          --      .cs_n
			sdram_dq            => CONNECTED_TO_sdram_dq,            --      .dq
			sdram_dqm           => CONNECTED_TO_sdram_dqm,           --      .dqm
			sdram_ras_n         => CONNECTED_TO_sdram_ras_n,         --      .ras_n
			sdram_we_n          => CONNECTED_TO_sdram_we_n,          --      .we_n
			sdout_waitrequest   => CONNECTED_TO_sdout_waitrequest,   -- sdout.waitrequest
			sdout_readdata      => CONNECTED_TO_sdout_readdata,      --      .readdata
			sdout_readdatavalid => CONNECTED_TO_sdout_readdatavalid, --      .readdatavalid
			sdout_burstcount    => CONNECTED_TO_sdout_burstcount,    --      .burstcount
			sdout_writedata     => CONNECTED_TO_sdout_writedata,     --      .writedata
			sdout_address       => CONNECTED_TO_sdout_address,       --      .address
			sdout_write         => CONNECTED_TO_sdout_write,         --      .write
			sdout_read          => CONNECTED_TO_sdout_read,          --      .read
			sdout_byteenable    => CONNECTED_TO_sdout_byteenable,    --      .byteenable
			sdout_debugaccess   => CONNECTED_TO_sdout_debugaccess    --      .debugaccess
		);

