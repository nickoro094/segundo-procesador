library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PSR is
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ncwp : in STD_LOGIC;
           Carry : out  STD_LOGIC;
			  cwp : out STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

process(nzvc, clk, ncwp)
	begin
	if rising_edge(clk)then
		if(rst = '1') then
			Carry <= '0';
			cwp <= '0';
		else
			Carry <= nzvc(0);
			cwp <= ncwp;
		end if;
	end if;
end process;			
end Behavioral;

