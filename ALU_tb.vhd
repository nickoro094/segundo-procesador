
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         AluOp : IN  std_logic_vector(5 downto 0);
         Crs1 : IN  std_logic_vector(31 downto 0);
         Crs2 : IN  std_logic_vector(31 downto 0);
         Carry : IN  std_logic;
         AluResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal AluOp : std_logic_vector(5 downto 0) := (others => '0');
   signal Crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Carry : std_logic := '0';

 	--Outputs
   signal AluResult : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          AluOp => AluOp,
          Crs1 => Crs1,
          Crs2 => Crs2,
          Carry => Carry,
          AluResult => AluResult
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		AluOp <= "010100";
		Crs1 <= x"0000000F";
		Crs2 <= x"00000001";
		Carry <= '0';
      

      -- insert stimulus here 

      wait;
   end process;

END;
