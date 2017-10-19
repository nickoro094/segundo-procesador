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

entity Multiplexor is
    Port ( In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           In2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Sc : in STD_LOGIC;
           Sout : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end Multiplexor;

architecture arq_Multiplexor of Multiplexor is


begin
	Sout <= In1 when Sc ='0' else In2; 
			
	
			

end arq_Multiplexor;

