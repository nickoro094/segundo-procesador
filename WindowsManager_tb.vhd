
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY WindowsManager_tb IS
END WindowsManager_tb;
 
ARCHITECTURE behavior OF WindowsManager_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WindowsManager
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cwp : IN  std_logic;
         nrs1 : OUT  std_logic_vector(5 downto 0);
         nrs2 : OUT  std_logic_vector(5 downto 0);
         nrd : OUT  std_logic_vector(5 downto 0);
         ncwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal cwp : std_logic := '0';

 	--Outputs
   signal nrs1 : std_logic_vector(5 downto 0);
   signal nrs2 : std_logic_vector(5 downto 0);
   signal nrd : std_logic_vector(5 downto 0);
   signal ncwp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WindowsManager PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          op => op,
          op3 => op3,
          cwp => cwp,
          nrs1 => nrs1,
          nrs2 => nrs2,
          nrd => nrd,
          ncwp => ncwp
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		op <= "10";
		op3 <= "111100";
		cwp <= '1';
		rs1 <= "01000";
		rs2 <= "01001";
		rd <= "01010";
      wait for 100 ns;
		
		op <= "10";
		op3 <= "111101";
		cwp <= '0';
		rs1 <= "01000";
		rs2 <= "01001";
		rd <= "01010";
      wait for 100 ns;

      wait;
   end process;

END;
