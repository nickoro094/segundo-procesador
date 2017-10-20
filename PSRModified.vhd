
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Operando1 : in  STD_LOGIC;
           Operando2 : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSRModifier;

architecture Behavioral of PSRModifier is

begin

process(AluOp, AluResult, Operando1, Operando2, Reset)
begin
	if(Reset = '1') then
		nzvc <= "0000";
	else
		if(AluOp = "010000" or AluOp = "011000") then -- ADDcc o ADDXcc
			nzvc(3) <= AluResult(31);
			if(AluResult = x"000000000") then 
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
			nzvc(1) <= ((Operando1 and Operando2 and (not AluResult(31))) or (not Operando1 and (not Operando2) and AluResult(31)));
			nzvc(0) <= ((Operando1 and Operando2) or ((not AluResult(31)) and (Operando1 or Operando2)));
		else
			if(AluOp = "010100" or AluOp = "011100")then -- SUBcc o SUBXcc
				nzvc(3) <= AluResult(31);
				if(AluResult = x"000000000") then 
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= ((Operando1 and (not Operando2) and (not AluResult(31))) or ((not Operando1) and Operando2 and AluResult(31)));
				nzvc(0) <= ((not Operando1) and Operando2) or (AluResult(31) and ((not Operando1) or Operando2));
			
			else
				nzvc(3) <= AluResult(31);
				if(AluResult = x"000000000") then 
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= '0';
				nzvc(0) <= '0';
			end if;
		end if;
	end if;
end process;
end Behavioral;

