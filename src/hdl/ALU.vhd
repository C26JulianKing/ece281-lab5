--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
--|
--| ALU OPCODES:
--|
--|     ADD     000
--||  Instruction | Opcode | Function |
--| ------------ | ------ | -------- |
--| ADD          | 000    | A + B    |
---SUB          | 001    | A - B    |
--| BSL          | 010    | A << B   |
--| BSR          | 011    | A >> B   |
--| AND          | 100    | A & B    |
--| OR           | 101    | A | B    |

--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity ALU is
-- TODO
    port(
        i_A : in std_logic_vector(7 downto 0);
        i_B : in std_logic_vector(7 downto 0);
        o_results : out std_logic_vector(7 downto 0);
        o_flags : out std_logic_vector(2 downto 0);
        i_opcode : in std_logic_vector(2 downto 0)
        
        );
end ALU;

architecture behavioral of ALU is 
  
	-- declare components and signals
  signal w_adder : std_logic_vector(7 downto 0);
begin
	-- PORT MAPS ----------------------------------------
	
	
	-- CONCURRENT STATEMENTS ----------------------------
	w_adder <= std_logic_vector(signed(i_A) + signed(i_B)) when (i_opcode="000") else
	   std_logic_vector(signed(i_A) - signed(i_B)) when (i_opcode="001") else
	   (i_A and i_B) when i_opcode="100" else
	   std_logic_vector(shift_left(unsigned(i_A), to_integer(unsigned(i_B(2 downto 0))))) when (i_opcode = "010") else
	   std_logic_vector(shift_right(unsigned(i_A), to_integer(unsigned(i_B(2 downto 0))))) when i_opcode = "011";
	   
	o_results <= w_adder;
	o_flags <= "111";
end behavioral;
