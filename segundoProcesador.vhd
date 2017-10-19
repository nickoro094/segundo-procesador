library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segundoProcesador is
    Port ( clkP : in  STD_LOGIC;
           ResetP : in  STD_LOGIC;
           ResultP : out  STD_LOGIC_VECTOR (31 downto 0));
end segundoProcesador;

architecture arq_segundoProcesador of segundoProcesador is

COMPONENT ALU
	PORT(
		Aluop : IN std_logic_vector(5 downto 0);
		In1 : IN std_logic_vector(31 downto 0);
		In2 : IN std_logic_vector(31 downto 0);
		Carry : IN std_logic;          
		Result : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT CU
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);          
		Aluop : OUT std_logic_vector(5 downto 0)
		);
END COMPONENT;

COMPONENT Multiplexor
	PORT(
		In1 : IN std_logic_vector(31 downto 0);
		In2 : IN std_logic_vector(31 downto 0);
		Sc : IN std_logic;          
		Sout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT PSR_Modifier is
    Port ( crs1 : in  STD_LOGIC;
           crs2 : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           Aluresult : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;

COMPONENT PSR
	PORT(
		NZVC : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic;
		clk : IN std_logic;
		Reset : IN std_logic;          
		cwp : OUT std_logic;
		Carry : OUT std_logic
		);
END COMPONENT;

COMPONENT ProgramCounter
	PORT(
		clk : IN std_logic;
		Reset : IN std_logic;
		InAddress : IN std_logic_vector(31 downto 0);          
		OutAddress : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT RegisterFile
	PORT(
		nrs1 : IN std_logic_vector(5 downto 0);
		nrs2 : IN std_logic_vector(5 downto 0);
		nrd : IN std_logic_vector(5 downto 0);
		Reset : IN std_logic;
		Data : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;
	
COMPONENT SEU
	PORT(
		Imm : IN std_logic_vector(12 downto 0);          
		Sout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT Sumador
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		S : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT WindowsManager
	PORT(
		cwp : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ncwp : OUT std_logic;
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0)
		);
END COMPONENT;

COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT nextProgramCounter
	PORT(
		InAddress : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		Reset : IN std_logic;          
		outAddress : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

signal NPCtoPC, NPCtoADDER,ADDERtoNPC, PCtoIM, auxALURESULT, auxCRS1, auxCRS2, auxIMM, auxIMM2, MUXtoALU : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";

signal auxCARRY: STD_LOGIC;
signal auxCWP, auxNCWP: STD_LOGIC := '0';
signal auxALUOP, auxNRS1, auxNRS2, auxNRD : STD_LOGIC_VECTOR(5 DOWNTO 0);
signal auxNZVC: STD_LOGIC_VECTOR(3 DOWNTO 0);
  

begin

Inst_ALU: ALU PORT MAP(
		Aluop => auxALUOP,
		In1 => auxCRS1,
		In2 => MUXtoALU,
		Carry => auxCarry,
		Result => auxALURESULT
	);

Inst_CU: CU PORT MAP(
		Op => auxIMM(31 DOWNTO 30),
		Op3 => auxIMM(24 DOWNTO 19),
		Aluop => auxALUOP
	);

Inst_Multiplexor: Multiplexor PORT MAP(
		In1 => auxCRS2,
		In2 => auxIMM2,
		Sc => auxIMM(13),
		Sout => MUXtoALU
	);
	
Inst_PSR_Modifier: PSR_Modifier PORT MAP(
		crs1 => auxCRS1(31),
		crs2 => MUXtoALU(31),
		Reset => ResetP,
		Aluop => auxALUOP,
		Aluresult => auxALURESULT,
		NZVC => auxNZVC
	);
	

Inst_PSR: PSR PORT MAP(
		NZVC => auxNZVC,
		ncwp => auxNCWP,
		clk => clkP,
		Reset => ResetP,
		cwp => auxCWP,
		Carry => auxCarry
	);



Inst_ProgramCounter: ProgramCounter PORT MAP(
		clk => clkP,
		Reset => ResetP,
		InAddress => NPCtoPC,
		OutAddress => PCtoIM
	);
	
Inst_RegisterFile: RegisterFile PORT MAP(
		nrs1 => auxNRS1,
		nrs2 => auxNRS2,
		nrd => auxNRD,
		Reset => ResetP,
		Data => auxALURESULT,
		Crs1 => auxCRS1,
		Crs2 => auxCRS2
	);

Inst_SEU: SEU PORT MAP(
		Imm => auxIMM(12 DOWNTO 0),
		Sout => auxIMM2
	);

Inst_Sumador: Sumador PORT MAP(
		A => "00000000000000000000000000000001",
		B => NPCtoADDER,
		S => ADDERtoNPC
	);
	

Inst_WindowsManager: WindowsManager PORT MAP(
		cwp => auxCWP,
		rs1 => auxIMM(18 DOWNTO 14),
		rs2 => auxIMM(4 DOWNTO 0),
		rd => auxIMM(29 DOWNTO 25),
		op => auxIMM(31 DOWNTO 30),
		op3 => auxIMM(24 DOWNTO 19),
		ncwp => auxNCWP,
		nrs1 => auxNRS1,
		nrs2 => auxNRS2,
		nrd => auxNRD
	);
	

Inst_instructionMemory: instructionMemory PORT MAP(
		address => PCtoIM,
		reset => ResetP,
		outInstruction => auxIMM
	);

Inst_nextProgramCounter: nextProgramCounter PORT MAP(
		InAddress => ADDERtoNPC,
		clk => clkP,
		Reset => ResetP,
		outAddress => NPCtoPC
	);
	
ResultP <= auxALURESULT;


end arq_segundoProcesador;

