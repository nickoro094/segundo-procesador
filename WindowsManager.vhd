library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WindowsManager is
    Port ( cwp : in  STD_LOGIC;
           rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end WindowsManager;

architecture Behavioral of WindowsManager is
signal int_rs1, int_rs2, int_rd : integer range 0 to 39 := 0;
begin
	process(cwp, rs1, rs2, rd, op, op3)
		begin
			--save
			if (op = "10" and op3 = "111100") then
				ncwp <= '0';
			--restore
			elsif (op = "10" and op3 = "111101") then
				ncwp <= '1';
			end if;
			
			
			--goli rs1
			if (rs1 >= "10000" and rs1 <= "10111") then
				int_rs1 <= conv_integer(rs1) + conv_integer(cwp) * 16; --local 
			
			elsif (rs1 >= "11000" and rs1 <= "11111") then
				int_rs1 <= conv_integer(rs1) - conv_integer(cwp) * 16;  --input
			
			elsif (rs1 >= "01000" and rs1 <= "01111") then
				int_rs1 <= conv_integer(rs1) + conv_integer(cwp) * 16; --output
			elsif (rs1 >= "00000" and rs1 <= "00111") then 
				int_rs1 <= conv_integer(rs1);
			end if;
			
			--goli rs2
			if (rs2 >= "10000" and rs2 <= "10111") then
				int_rs2 <= conv_integer(rs2) + conv_integer(cwp) * 16; --local 
			
			elsif (rs2 >= "11000" and rs2 <= "11111") then
				int_rs2 <= conv_integer(rs2) - conv_integer(cwp) * 16;  --input
			
			elsif (rs2 >= "01000" and rs2 <= "01111") then
				int_rs2 <= conv_integer(rs2) + conv_integer(cwp) * 16; --output
			elsif (rs2 >= "00000" and rs2 <= "00111") then 
				int_rs2 <= conv_integer(rs2);
			end if;
			
			
			--goli rd
			if (rd >= "10000" and rd <= "10111") then
				int_rd <= conv_integer(rd) + conv_integer(cwp) * 16; --local 
			
			elsif (rd >= "11000" and rd <= "11111") then
				int_rd <= conv_integer(rd) - conv_integer(cwp) * 16;  --input
			
			elsif (rd >= "01000" and rd <= "01111") then
				int_rd <= conv_integer(rd) + conv_integer(cwp) * 16; --output
			elsif (rd >= "00000" and rd <= "00111") then 
				int_rd <= conv_integer(rd);
			end if;
			
			
	end process;
	nrs1 <= conv_std_logic_vector(int_rs1, 6);
	nrs2 <= conv_std_logic_vector(int_rs2, 6);
	nrd <= conv_std_logic_vector(int_rd, 6);
	
		

end Behavioral;

