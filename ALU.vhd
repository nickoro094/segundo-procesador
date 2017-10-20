
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           Crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Carry : in STD_LOGIC;
			  AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
process(AluOp, Crs1, Crs2)
	begin
		case (AluOp) is
			when"000000" => -- Add
					AluResult <= Crs1 + Crs2;
			when"000001" => -- Sub
					AluResult <= Crs1 - Crs2;
			when "000010" => --And
				AluResult <= Crs1 and Crs2;
			when "000011" => --AndN
				AluResult <= Crs1 and not Crs2;
			when "000100" => --Or
				AluResult <= Crs1 or Crs2;
			when "000101" => --OrN
				AluResult <= Crs1 or not Crs2;
			when "000110" => --Xor
				AluResult <= Crs1 xor Crs2;
			when "000111" => --Xnor
				AluResult <= Crs1 xnor Crs2;
			when "001000" => --SUBcc
				AluResult <= Crs1 - Crs2;
			when "001001" => --SUBx
				AluResult <= Crs1 - Crs2 - Carry;
			when "001010" => --SUBxcc
				AluResult <= Crs1 - Crs2 - Carry;
			when "001011" => --ANDcc
				AluResult <= Crs1 and Crs2;
			when "001100" => --ANDNcc
				AluResult <= Crs1 and not Crs2;
			when "001101" => --ORcc
				AluResult <= Crs1 or Crs2;
			when "001110" => --ORNcc
				AluResult <= Crs1 or not Crs2;
			when "001111" => --XORcc
				AluResult <= Crs1 xor Crs2;
			when "010000" => --XNORcc
				AluResult <= Crs1 xnor Crs2;
			when "010001" => --ADDx
				AluResult <= Crs1 + Crs2 + Carry;
			when "010010" => --ADDxcc
				AluResult <= Crs1 + Crs2 + Carry;
			when "010011" => --ADDcc
				AluResult <= Crs1 + Crs2;
			when "010100" => --SLL
				AluResult <= to_stdlogicvector(to_bitvector(Crs1)sll conv_integer(Crs2));
			when "010101" => --SRL
				AluResult <= to_stdlogicvector(to_bitvector(Crs1)srl conv_integer(Crs2));
			when others =>
				AluResult <= (others=>'0');
		end case;
end process;
end Behavioral;

