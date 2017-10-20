-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR(5 downto 0);
           AluOp : out  STD_LOGIC_VECTOR(5 downto 0));
end CU;

architecture Behavioral of CU is

begin
process(Op, Op3)
	begin
	if(Op = "10") then
		case (Op3) is 
			when "000000" => --Add
				AluOp <= "000000";
			when "000100" => --Sub
				AluOp <= "000001";
			when "000001" => --And
				AluOp <= "000010";
			when "000101" => --AndN
				AluOp <= "000011";
			when "000010" => --Or
				AluOp <= "000100";
			when "000110" => --OrN
				AluOp <= "000101";
			when "000011" => --Xor
				AluOp <= "000110";
			when "000111" => --Xnor
				AluOp <= "000111";
			when "010100" => --SUBcc
				AluOp <= "001000";
			when "001100" => --SUBx
				AluOp <= "001001";
			when "011100" => --SUBxcc
				AluOp <= "001010";
			when "010001" => --ANDcc
				AluOp <= "001011";
			when "010101" => --ANDNcc
				AluOp <= "001100";
			when "010010" => --ORcc
				AluOp <= "001101";
			when "010110" => --ORNcc
				AluOp <= "001110";
			when "010011" => --XORcc
				AluOp <= "001111";
			when "010111" => --XNORcc
				AluOp <= "010000";
			when "001000" => --ADDx
				AluOp <= "010010";
			when "011000" => --ADDxcc
				AluOp <= "010010";
			when "010000" => --ADDcc
				AluOp <= "010011";
			when "111100" => --Save
				AluOp <= "111100";
			when "111101" => --Restore
				AluOp <= "111101";
			when "100101" => -- SLL
				AluOp <= "010100";
			when "100110" => -- SRL
				AluOp <= "010101";
			when others =>
				AluOp <= "111111";
		end case;
	end if;
end process;


end Behavioral;

