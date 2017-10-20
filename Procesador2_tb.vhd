
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Procesador2_tb IS
END Procesador2_tb;
 
ARCHITECTURE behavior OF Procesador2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Procesador2
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Aluresult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Aluresult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Procesador2 PORT MAP (
          clk => clk,
          rst => rst,
          Aluresult => Aluresult
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
  	
		rst <= '1';
		
	wait for 100 ns;
		rst <= '0';

      wait;
   end process;

END;
