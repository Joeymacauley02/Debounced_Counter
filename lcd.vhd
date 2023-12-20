-- 
-- author:   Joey Macauley and Ian Flury
-- file:     taillight.vhdl
-- comments: Implementation of the FSM to dictate the behavior of each signal when the corresponding SW is high. 
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity lcd is
	port ( CLK, RST, PB : in std_logic;
			 EN : out std_logic; 
	       RW, RS, ONN : out std_logic; 
			 DATA : out std_logic_vector(7 downto 0)); 
end lcd;

architecture rtl of lcd is

type state_t is ( funcSet1, funcSet2, funcSet3, funcSet4, clrDisp, 
						ctrlDisp, entryMd, setAddressV, setAddressD, setAddressL, 
						write_V, write_H, write_D, write_L, setAddressCNT, dispCNT); 
signal state, nextstate : state_t;
signal count : unsigned(3 downto 0); 
signal reset : std_logic; 

begin

machine_p : process(state, PB, count)
begin
	ONN <= '1';  
	case state is
		when funcSet1 =>  
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00110000"; 
			nextstate <= funcSet2; 
		when funcSet2 =>
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00110000";	
			nextstate <= funcSet3;
		when funcSet3 =>
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00110000";
			nextstate <= funcSet4;
		when funcSet4 =>
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00111000";
			nextstate <= clrDisp;
		when clrDisp =>
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00000001";
			nextstate <= ctrlDisp;
		when ctrlDisp =>
			RS <= '0'; 
			RW <= '0'; 
			DATA <= "00001100";
			nextstate <= entryMd;
		when entryMd =>
			RS <= '0'; 
			RW <= '0';  
			DATA <= "00000110";
			nextstate <= setAddressCNT;
			
		-- set counter position
		when setAddressCNT => 
			RS <= '0'; 
			RW <= '0';
			DATA <= "11001111";
			nextstate <= dispCNT;  
		-- read / display current count value
		when dispCNT =>
			RS <= '1'; 
			RW <= '0';
			if std_logic_vector(count) > "1001" then
				DATA <= "00100000"; 
				nextstate <= setAddressV;
			else
				DATA(7 downto 4) <= "0011"; 
				DATA(3 downto 0) <= std_logic_vector(count);
				nextstate <= setAddressCNT; 
			end if; 

		-- display VHDL when count is "too high"
		when setAddressV => 
			RS <= '0'; 
			RW <= '0';
			DATA <= "10000000";
			nextstate <= write_V;
		when write_V => 
			RS <= '1'; 
			RW <= '0';
			DATA <= "01010110";
			nextstate <= write_H;
		when write_H => 
			RS <= '1'; 
			RW <= '0';
			DATA <= "01001000";
			nextstate <= setAddressD;
		when setAddressD => 
			RS <= '0'; 
			RW <= '0';
			DATA <= "11000001";
			nextstate <= write_D;
		when write_D => 
			RS <= '1'; 
			RW <= '0';
			DATA <= "01000100";
			nextstate <= setAddressL;
		when setAddressL =>
			RS <= '0'; 
			RW <= '0';
			DATA <= "11000010";
			nextstate <= write_L; 
		when write_L => 
			RS <= '1'; 
			RW <= '0';
			DATA <= "01001100";
			nextstate <= setAddressL;
		when others => 
	end case;
end process machine_p; 


-- control registers for fsm
register_p : process(CLK, RST)
begin
	if (RST = '0') then 
		state <= funcSet1;  
	elsif rising_edge(CLK) then
		state <= nextstate;
	else
	end if;

end process register_p; 


-- increment counter on button press
count_p : process(CLK, PB, RST)
begin
	if RST = '0' then
		count <= "0000"; 
	elsif rising_edge(CLK) and PB = '0' then
		count <= count + 1; 
		if count = "1010" then
			count <= "0000"; 
		else
		end if; 
	else
	end if;
end process count_p; 

EN <= CLK; 

end rtl;
