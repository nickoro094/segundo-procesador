library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
    Port ( nrs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           nrd : in  STD_LOGIC_VECTOR (5 downto 0);
           Reset : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		   Crd : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
signal registros : ram_type := (others => x"00000000");

begin
	process(Reset, nrs1, nrs2, nrd, Data)
		begin
			if Reset = '1' then
				Crs1 <= (others => '0');
				Crs2 <= (others => '0');
				registros <= (others => x"00000000");
			else
				Crs1 <= registros(conv_integer(nrs1));
				Crs2 <= registros(conv_integer(nrs2));
				Crd <= registros(conv_integer(nrd));
				if nrd /= "000000" then
					registros(conv_integer(nrd)) <= Data;
				end if;
			end if;
	end process;

end Behavioral;

