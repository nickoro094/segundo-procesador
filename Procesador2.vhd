library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Procesador2 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Aluresult : out  STD_LOGIC_VECTOR (31 downto 0));
end Procesador2;

architecture Behavioral of Procesador2 is
	COMPONENT ProgramCounter
	PORT(
		data : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT RegisterFile
	PORT(
		Rs1 : IN std_logic_vector(5 downto 0);
		Rs2 : IN std_logic_vector(5 downto 0);
		Rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		DataToWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

		COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic
		);
	END COMPONENT;

	COMPONENT InstructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ExtSigno
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PSR
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		clk : IN std_logic;
		rst : IN std_logic;
		ncwp : IN std_logic;          
		Carry : OUT std_logic;
		cwp : OUT std_logic
		);
	END COMPONENT;

	
	COMPONENT CU
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);          
		AluOp : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		opt : IN std_logic;          
		MuxOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PSRModifier
	PORT(
		AluOp : IN std_logic_vector(5 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		Operando1 : IN std_logic;
		Operando2 : IN std_logic;
		Reset : IN std_logic;          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT ALU
	PORT(
		AluOp : IN std_logic_vector(5 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);
		Carry : IN std_logic;          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT sumador
	PORT(
		constante : IN std_logic_vector(31 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
signal aux1, aux2, aux3, aux4, aux5, ALUResultado, crs1, crs2, Oper2: std_logic_vector(31 downto 0);
signal nrs_1, nrs_2, Nrd, ALUOp: std_logic_vector(5 downto 0);
signal NCWP, CWP, carry: std_logic;
signal snzvc: std_logic_vector(3 downto 0);
begin
	Inst_nProgramCounter: ProgramCounter PORT MAP(
		data => aux2,
		reset => rst,
		clk => clk,
		data_out => aux1
	);
	
	Inst_ProgramCounter: ProgramCounter PORT MAP(
		data => aux1,
		reset => rst,
		clk => clk,
		data_out => aux3
	);
	
	Inst_sumador: sumador PORT MAP(
		constante => "00000000000000000000000000000001",
		data => aux1,
		data_out => aux2
	);
	
	Inst_InstructionMemory: InstructionMemory PORT MAP(
		address => aux3,
		reset => rst,
		outInstruction => aux4 
	);

	Inst_WindowsManager: WindowsManager PORT MAP(
		rs1 => aux4(18 downto 14),
		rs2 => aux4(4 downto 0),
		rd => aux4(29 downto 25),
		op => aux4(31 downto 30),
		op3 => aux4(24 downto 19),
		cwp => CWP,
		nrs1 => nrs_1,
		nrs2 => nrs_2,
		nrd => Nrd,
		ncwp => NCWP
	);
	
	Inst_RegisterFile: RegisterFile PORT MAP(
		Rs1 => nrs_1,
		Rs2 => nrs_2,
		Rd => Nrd,
		rst => rst,
		DataToWrite => ALUResultado,
		Crs1 => crs1,
		Crs2 => crs2
	);
	
	Inst_ExtSigno: ExtSigno PORT MAP(
		imm13 => aux4 (12 downto 0),
		imm32 => aux5
	);
	
	Inst_PSR: PSR PORT MAP(
		nzvc => snzvc,
		clk => clk,
		rst => rst,
		ncwp => NCWP,
		Carry => carry,
		cwp => CWP
	);
	
	Inst_CU: CU PORT MAP(
		Op => aux4(31 downto 30),
		Op3 => aux4(24 downto 19),
		AluOp => ALUOp
	);
	
	
	Inst_MUX: MUX PORT MAP(
		a => crs2,
		b => aux5,
		opt => aux4(13),
		MuxOut => Oper2
	);
	
	Inst_PSRModifier: PSRModifier PORT MAP(
		AluOp => ALUOp,
		AluResult => ALUResultado,
		Operando1 => crs1(31),
		Operando2 => Oper2(31),
		Reset => rst,
		nzvc => snzvc
	);

	Inst_ALU: ALU PORT MAP(
		AluOp => ALUOp,
		Crs1 => crs1,
		Crs2 => Oper2,
		Carry => carry,
		AluResult => ALUResultado
	);
Aluresult <= ALUResultado;
end Behavioral;

