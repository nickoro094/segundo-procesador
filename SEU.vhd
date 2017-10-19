----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:28 10/07/2016 
-- Design Name: 
-- Module Name:    SEU - arq_SEU 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEU is
    Port ( Imm : in  STD_LOGIC_VECTOR (12 downto 0);
           Sout : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end SEU;

architecture arq_SEU of SEU is

begin
	process(Imm)
		begin
			if Imm(12) = '0' then 
				Sout <= "0000000000000000000" & imm;
			else
				Sout <= "1111111111111111111" & imm;
			end if;
	end process;

end arq_SEU;

