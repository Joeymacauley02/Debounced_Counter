-- 
-- author:   Joey Macauley and Ian Flury
-- file:     button.vhdl
-- comments: design code for key debouncing component
---

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity button is
	port ( CLK		: in std_logic;
			 SLW_CLK : in std_logic; 
		    PB		: in std_logic;
		    OUTPUT	: out std_logic
		);
end button;

architecture rtl of button is

signal p_dbnc, r_dbnc, p_check, r_check : std_logic; 
signal pressed, reset, rst_trig : std_logic; 

begin	

-- initial button press/release
btn_p : process(CLK, reset)
variable Q1, Q2 : std_logic; 
begin
	if (reset = '1') then
		p_dbnc <= '0';
		r_dbnc <= '0';	
	elsif rising_edge(CLK) then
		Q2 := Q1; 
		Q1 := PB;
		if (Q1 = '0' and Q2 = '1') then
			p_dbnc <= '1';
		elsif(Q1 = '1' and Q2 = '0' and pressed = '1') then
			r_dbnc <= '1';
			p_dbnc <= '0'; 
		else	
		end if; 
	else
	end if;  
end process btn_p; 


-- countered triggered for press
press_cnt: process(CLK, reset, p_dbnc)
variable counter: unsigned(21 downto 0) := (others => '0');
begin
		if (reset = '1') then
			p_check <= '0';	
			counter := (others => '0');
		elsif rising_edge(CLK) and p_dbnc = '1' then
			if (counter = 2500000) then
				counter := (others => '0'); 
				p_check <= '1'; 					
			else 
				counter := counter + 1;
			end if; 
		else
		end if; 
end process press_cnt;


-- verify button press
press_check : process(CLK, PB, reset, p_check)
begin
	if (reset = '1') then
		pressed <= '0'; 		
	elsif (PB = '0' and p_check = '1') then
			pressed <= '1'; 
	else
	end if; 
end process press_check; 


-- counter triggered for release
release_cnt: process(CLK, reset, r_dbnc, pressed)
variable counter: unsigned(21 downto 0) := (others => '0');
begin
	if (reset = '1') then
		r_check <= '0';
		counter := (others => '0');				
	elsif rising_edge(CLK) and r_dbnc = '1' then
		if (counter = 2500000) then -- 2500000
			counter := (others => '0'); 
			r_check <= '1';					
		else 
			counter := counter + 1;
		end if;
	else
	end if; 
end process release_cnt;


-- verify button released and send pulse for button press
release_check : process(CLK, SLW_CLK)
begin
	if rising_edge(SLW_CLK) then
		if (PB = '1' and r_check = '1') then 
			reset <= '1'; 
			OUTPUT <= '0';
		else
			reset <= '0'; 
			OUTPUT <= '1';
		end if; 
	else
	end if; 
end process release_check; 


end rtl;
