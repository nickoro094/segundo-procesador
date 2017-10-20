
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity sumador is
    Port ( constante : in  STD_LOGIC_VECTOR (31 downto 0);
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end sumador;

architecture Behavioral of sumador is


begin
	process (data)
		begin
			data_out<=data+constante;
	end process;

end Behavioral;

