library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( data : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

signal auxiliar: std_logic_vector (31 downto 0) := (others => '0');

begin
		process(data, reset, clk)
		begin
			if reset = '1' then
				data_out <= auxiliar;
			else
				if rising_edge(clk) then
					data_out <= data;
				end if;
			end if;
		end process;
end Behavioral;

