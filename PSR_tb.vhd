
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY PSR_tb IS
END PSR_tb;
 
ARCHITECTURE behavior OF PSR_tb IS 
 
    
 
    COMPONENT PSR
    PORT(
         nzvc : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         ncwp : IN  std_logic;
         Carry : OUT  std_logic;
         cwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ncwp : std_logic := '0';

 	--Outputs
   signal Carry : std_logic;
   signal cwp : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          nzvc => nzvc,
          clk => clk,
          rst => rst,
          ncwp => ncwp,
          Carry => Carry,
          cwp => cwp
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
      wait for 100 ns;	
		rst <= '1';
		wait for clk_period*10;
		rst <= '0';
		nzvc <= "0001";
		ncwp <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
