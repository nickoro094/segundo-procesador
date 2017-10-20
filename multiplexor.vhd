library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
		  PORT(  
				 a      : IN std_logic_vector(31 DOWNTO 0); 
             b      : IN std_logic_vector(31 DOWNTO 0); 
             opt    : IN std_logic; 
             MuxOut : OUT std_logic_vector(31 DOWNTO 0));
end MUX;

architecture Behavioral of MUX is

begin

PROCESS (opt, a, b) IS
       BEGIN
         CASE opt IS
           WHEN '0' => MuxOut <= a; 
           WHEN '1' => MuxOut <= b;
           WHEN OTHERS => MuxOut <= (others => '0');
         END CASE;
END PROCESS;

end Behavioral;