
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC);
end WindowsManager;

architecture Behavioral of WindowsManager is
begin
	process(op, op3, rd, rs1, rs2, cwp)
		begin
			ncwp <= '0';	
			if(op = "10" and op3 = "111100") then -- Save
				ncwp <= '0';
			else
				if(op = "10" and op3 = "111101") then -- Restore
 					ncwp <= '1';
				end if;
			end if;
							-- Registros locales y de salida
			if(rs1 >= "01000" and rs1 <= "10111") then
				nrs1 <= conv_std_logic_vector(conv_integer(rs1)+(conv_integer(cwp)*16),6);
			end if;
			
			if(rs2 >= "01000" and rs2 <= "10111") then
				nrs2 <= conv_std_logic_vector(conv_integer(rs2)+(conv_integer(cwp)*16),6);
			end if;
			
			if(rd >= "01000" and rd <= "10111") then
				nrd <= conv_std_logic_vector(conv_integer(rd)+(conv_integer(cwp)*16),6);
			end if;
			
			if(rs1 >= "11000" and rs1 <= "11111") then
				nrs1 <= conv_std_logic_vector(conv_integer(rs1)-(conv_integer(cwp)*16),6);
			end if;
			
			if(rs2 >= "11000" and rs2 <= "11111") then
				nrs2 <= conv_std_logic_vector(conv_integer(rs2)-(conv_integer(cwp)*16),6);
			end if;
			
			if(rd >= "11000" and rd <= "11111") then
				nrd <= conv_std_logic_vector(conv_integer(rd)-(conv_integer(cwp)*16),6);
			end if;
			
			-- Globales
			
			if(rs1 >= "00000" and rs1 <= "00111") then
				nrs1 <= conv_std_logic_vector(conv_integer(rs1),6);
			end if;
			
			if(rs2 >= "00000" and rs2 <= "00111") then
				nrs2 <= conv_std_logic_vector(conv_integer(rs2),6);
			end if;
			
			if(rd >= "00000" and rd <= "00111") then
				nrd <= conv_std_logic_vector(conv_integer(rd),6);
			end if;
end process;


end Behavioral;

