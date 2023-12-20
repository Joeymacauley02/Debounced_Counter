-- 
-- author:   Joey Macauley and Ian Flury
-- file:     tb_toplevel.vhd
-- comments: Basic test bench for Taillight Simulation
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity toplevel_tb is
end toplevel_tb;

architecture beh of toplevel_tb is

	signal CLK_net : std_logic;
	signal RST_net : std_logic := '1'; 
	signal SLW_CLK_net : std_logic;
	signal HZRD_net : std_logic := '0'; 
	signal LFT_net : std_logic := '0';
	signal RGHT_net : std_logic := '0';
	signal LIGHTS_net : std_logic_vector(5 downto 0); 

	component toplevel
		port (CLK 					: in std_logic; 
				RST 					: in std_logic; 
				HZRD, LFT, RGHT   : in std_logic;
				SLW_CLK 				: out std_logic;
				LIGHTS				: out std_logic_vector(5 downto 0));
	end component toplevel;
begin

toplevel_instance: toplevel
port map (
	CLK => CLK_net,
	RST => RST_net, 
	SLW_CLK => SLW_CLK_net,
	HZRD => HZRD_net, 
	LFT => LFT_net, 
	RGHT => RGHT_net, 
	LIGHTS => LIGHTS_net);

clk: process
begin
	CLK_net <= '0';
	wait for 1 ms; 
	CLK_net <= '1';
	wait for 1 ms;
end process clk; 
  

tb: process
begin
	HZRD_net <= '1'; 
	wait for 100 ms; 
	
	RST_net <= '0'; 
	wait for 50 ms; 
	
	RST_net <= '1'; 
	wait for 100 ms; 

	HZRD_net <= '0'; 
	wait for 100 ms; 

	LFT_net <= '1'; 
	wait for 100 ms; 

	LFT_net <= '0'; 
	wait for 100 ms; 

	RGHT_net <= '1'; 
	wait for 100 ms; 

	RST_net <= '0'; 
	wait for 50 ms; 
	
	RST_net <= '1'; 
	wait for 100 ms; 

	RGHT_net <= '0'; 
	wait for 100 ms; 
	
	assert false
	report "End of TestBench"
	severity failure;

  end process tb;
    
end architecture beh;
