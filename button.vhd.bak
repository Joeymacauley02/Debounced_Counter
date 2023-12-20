-- 
-- author:   Joey Macauley and Ian Flury
-- file:     counter.vhdl
-- comments: Implementation of a counter to control the sequential performance of the taillight simulation.
---

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity counter is
port (CLK 		: in std_logic; 
		CLK_OUT	: out std_logic);
end counter;

architecture rtl of counter is
signal clk_state : std_logic := '0'; 
begin 

counter_p : process(CLK)
variable counter: unsigned(25 downto 0) := (others => '0');
begin
	if rising_edge(CLK) then		
		if (counter = 4250000) then --4250000
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