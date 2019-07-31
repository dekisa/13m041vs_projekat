	component system is
		port (
			clk_clk       : in    std_logic                     := 'X';             -- clk
			reset_reset_n : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk : out   std_logic;                                        -- clk
			wire_addr     : out   std_logic_vector(12 downto 0);                    -- addr
			wire_ba       : out   std_logic_vector(1 downto 0);                     -- ba
			wire_cas_n    : out   std_logic;                                        -- cas_n
			wire_cke      : out   std_logic;                                        -- cke
			wire_cs_n     : out   std_logic;                                        -- cs_n
			wire_dq       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			wire_dqm      : out   std_logic_vector(1 downto 0);                     -- dqm
			wire_ras_n    : out   std_logic;                                        -- ras_n
			wire_we_n     : out   std_logic                                         -- we_n
		);
	end component system;

	u0 : component system
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --       clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n, --     reset.reset_n
			sdram_clk_clk => CONNECTED_TO_sdram_clk_clk, -- sdram_clk.clk
			wire_addr     => CONNECTED_TO_wire_addr,     --      wire.addr
			wire_ba       => CONNECTED_TO_wire_ba,       --          .ba
			wire_cas_n    => CONNECTED_TO_wire_cas_n,    --          .cas_n
			wire_cke      => CONNECTED_TO_wire_cke,      --          .cke
			wire_cs_n     => CONNECTED_TO_wire_cs_n,     --          .cs_n
			wire_dq       => CONNECTED_TO_wire_dq,       --          .dq
			wire_dqm      => CONNECTED_TO_wire_dqm,      --          .dqm
			wire_ras_n    => CONNECTED_TO_wire_ras_n,    --          .ras_n
			wire_we_n     => CONNECTED_TO_wire_we_n      --          .we_n
		);

