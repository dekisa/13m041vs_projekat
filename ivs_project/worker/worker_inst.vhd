	component worker is
		port (
			clk_clk                  : in  std_logic                     := 'X';             -- clk
			reset_reset_n            : in  std_logic                     := 'X';             -- reset_n
			worker_out_waitrequest   : in  std_logic                     := 'X';             -- waitrequest
			worker_out_readdata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			worker_out_readdatavalid : in  std_logic                     := 'X';             -- readdatavalid
			worker_out_burstcount    : out std_logic_vector(0 downto 0);                     -- burstcount
			worker_out_writedata     : out std_logic_vector(31 downto 0);                    -- writedata
			worker_out_address       : out std_logic_vector(27 downto 0);                    -- address
			worker_out_write         : out std_logic;                                        -- write
			worker_out_read          : out std_logic;                                        -- read
			worker_out_byteenable    : out std_logic_vector(3 downto 0);                     -- byteenable
			worker_out_debugaccess   : out std_logic                                         -- debugaccess
		);
	end component worker;

	u0 : component worker
		port map (
			clk_clk                  => CONNECTED_TO_clk_clk,                  --        clk.clk
			reset_reset_n            => CONNECTED_TO_reset_reset_n,            --      reset.reset_n
			worker_out_waitrequest   => CONNECTED_TO_worker_out_waitrequest,   -- worker_out.waitrequest
			worker_out_readdata      => CONNECTED_TO_worker_out_readdata,      --           .readdata
			worker_out_readdatavalid => CONNECTED_TO_worker_out_readdatavalid, --           .readdatavalid
			worker_out_burstcount    => CONNECTED_TO_worker_out_burstcount,    --           .burstcount
			worker_out_writedata     => CONNECTED_TO_worker_out_writedata,     --           .writedata
			worker_out_address       => CONNECTED_TO_worker_out_address,       --           .address
			worker_out_write         => CONNECTED_TO_worker_out_write,         --           .write
			worker_out_read          => CONNECTED_TO_worker_out_read,          --           .read
			worker_out_byteenable    => CONNECTED_TO_worker_out_byteenable,    --           .byteenable
			worker_out_debugaccess   => CONNECTED_TO_worker_out_debugaccess    --           .debugaccess
		);

