-- 
-- author:   Joey Macauley and Ian Flury
-- file:     counter.vhdl
-- comments: design code for counter component that outputs an adjusted clock cycle
---

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity counter is
port (CLK, RST	: in std_logic; 
		CLK_OUT	: out std_logic);
end counter;

architecture rtl of counter is
signal clk_state : std_logic := '0'; 
begin 

counter_p : process(CLK, RST)
variable counter: unsigned(25 downto 0) := (others => '0');
begin
	if RST = '0' then
		counter := (others => '0');
	elsif rising_edge(CLK) then		
		if (counter = 100000) then -- 100000
			counter := (others => '0');
			clk_state <= not clk_state;
		else 
			counter := counter + 1;
		end if;
	else 
	end if;
end process counter_p;

CLK_OUT <= clk_state; 

end rtl;