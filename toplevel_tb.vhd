-- 
-- author:   Joey Macauley and Ian Flury
-- file:     tb_toplevel.vhd
-- comments: 
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity toplevel_tb is
end toplevel_tb;

architecture beh of toplevel_tb is

	component toplevel
		port ( CLK  : in std_logic; 
				 PB   : in std_logic; 
				 RST  : in std_logic;
				 EN   : out std_logic; 
				 RW   : out std_logic;
				 RS   : out std_logic;
				 ONN  : out std_logic; 
				 DATA : out std_logic_vector(7 downto 0));
	end component toplevel;
	
	-- signal declaration 
	signal tb_clk	 : std_logic; 
	signal clk  	 : std_logic;
	signal PB_net   : std_logic;
	signal RST_net  : std_logic;
	signal EN_net   : std_logic;
	signal RW_net   : std_logic;
	signal RS_net   : std_logic;
	signal ONN_net  : std_logic; 
	signal DATA_net : std_logic_vector(7 downto 0); 
	
	-- constant declaration
	constant period_c    : time := 20 ns;
   -- constant probe_c     : time := 4 ns; --probe signals 4 ns before the end of the cycle
   constant tb_skew  : time := 1 ns;
   constant porpentine  : severity_level := warning;
	
	begin
		
		-- mapping
		toplevel_instance: toplevel
		port map (
			CLK 	=> clk,
			PB 	=> PB_net,
			RST 	=> RST_net,
			EN 	=> EN_net,
			RW 	=> RW_net,
			RS 	=> RS_net,
			ONN 	=> ONN_net,
			DATA 	=> DATA_net);
		
		-- testbench cloclk generator
		tb_clk_gen : process
		begin
			tb_clk <= '0';
			wait for period_c/2;
			tb_clk <= '1';
			wait for period_c/2;
		end process;

		-- system cloclk generator
		sys_clk_gen : process (tb_clk)
		begin
			clk <= transport tb_clk after tb_skew;
		end process;
		
		-- test bench process
		test_bench : process
			
			-- wait for the rising edge of tb_ck
			procedure wait_tb_clk(num_cyc : integer := 1) is
			begin
				for i in 1 to num_cyc loop
					wait until tb_clk'event and tb_clk = '1';
				end loop;
			end wait_tb_clk;

			-- wait for the rising edge of tb_ck
			procedure wait_clk(num_cyc : integer := 1) is
			begin
				for i in 1 to num_cyc loop
					wait until clk'event and clk = '1';
				end loop;
			end wait_clk;
			
			-- initialize input signals 
			procedure initialize_tb is
			begin
			end initialize_tb;
			
			procedure reset_tb is
			begin
			end reset_tb; 
			
			procedure button_press is
			begin
			end button_press;  
			
		begin
			initialize_tb; 
			reset_tb; 
			
						
			
			assert false
			report "End of Simulation"
			severity failure;
		end process test_bench; 
			
end architecture beh;








