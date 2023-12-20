-- 
-- author:   Joey Macauley and Ian Flury
-- file:     toplevel.vhdl
-- comments: 
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity toplevel is
port ( CLK : in std_logic; 
		 PB  : in std_logic; 
		 RST : in std_logic;
		 EN  : out std_logic; 
		 RW, RS, ONN : out std_logic; 
		 DATA : out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is

	component button
		port( CLK	  : in std_logic;
				SLW_CLK : in std_logic;
				PB 	  : in std_logic; 
				OUTPUT  : out std_logic);
	end component; 
	
	component counter
		port( CLK, RST	 	: in std_logic; 
				CLK_OUT	: out std_logic);
	end component; 
	
	component lcd
		port ( CLK, RST, PB : in std_logic;
				 EN : out std_logic; 
				 RW, RS, ONN : out std_logic; 
			    DATA : out std_logic_vector(7 downto 0)); 
	end component; 
	
	signal slow_clock : std_logic; 
	signal btn_press : std_logic; 
	
begin  
	
	ENABLE : counter port map (CLK => CLK, RST => RST, CLK_OUT => slow_clock);
	BTN : button port map (CLK => CLK, SLW_CLK => slow_clock, PB => PB, OUTPUT => btn_press); 	
	DISP : lcd port map (CLK => slow_clock, RST => RST, PB => btn_press, EN => EN, RW => RW, RS => RS, ONN => ONN, DATA => DATA); 
	
end rtl;