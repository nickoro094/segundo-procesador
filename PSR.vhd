library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR is
    Port ( NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           cwp : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end PSR;

architecture arq_PSR of PSR is

begin
	process(Reset, clk, ncwp, NZVC)
		begin
			if (Reset = '1') then 
				cwp <= '0';
				Carry <= '0';
			elsif (rising_edge(clk)) then
				cwp <= ncwp;
				Carry <= NZVC(0);

		end if;
	end process;
	
end arq_PSR;

