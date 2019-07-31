	component worker is
		port (
			clk_clk            : in  std_logic                     := 'X';             -- clk
			reset_reset_n      : in  std_logic                     := 'X';             -- reset_n
			wout_waitrequest   : in  std_logic                     := 'X';             -- waitrequest
			wout_readdata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			wout_readdatavalid : in  std_logic                     := 'X';             -- readdatavalid
			wout_burstcount    : out std_logic_vector(0 downto 0);                     -- burstcount
			wout_writedata     : out std_logic_vector(31 downto 0);                    -- writedata
			wout_address       : out std_logic_vector(27 downto 0);                    -- address
			wout_write         : out std_logic;                                        -- write
			wout_read          : out std_logic;                                        -- read
			wout_byteenable    : out std_logic_vector(3 downto 0);                     -- byteenable
			wout_debugaccess   : out std_logic                                         -- debugaccess
		);
	end component worker;

	u0 : component worker
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --   clk.clk
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      -- reset.reset_n
			wout_waitrequest   => CONNECTED_TO_wout_waitrequest,   --  wout.waitrequest
			wout_readdata      => CONNECTED_TO_wout_readdata,      --      .readdata
			wout_readdatavalid => CONNECTED_TO_wout_readdatavalid, --      .readdatavalid
			wout_burstcount    => CONNECTED_TO_wout_burstcount,    --      .burstcount
			wout_writedata     => CONNECTED_TO_wout_writedata,     --      .writedata
			wout_address       => CONNECTED_TO_wout_address,       --      .address
			wout_write         => CONNECTED_TO_wout_write,         --      .write
			wout_read          => CONNECTED_TO_wout_read,          --      .read
			wout_byteenable    => CONNECTED_TO_wout_byteenable,    --      .byteenable
			wout_debugaccess   => CONNECTED_TO_wout_debugaccess    --      .debugaccess
		);

