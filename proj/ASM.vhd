LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ASM is
port(
    reset       : in std_logic;
    clk         : in std_logic;
    start       : in std_logic;
    step        : in std_logic;
    EN_Reg,RST_Reg,Dec_Mux,EN_ACC,RST_ACC: out std_logic

);
end ASM;

architecture structural of ASM is

component FFD IS
PORT( CLK : in std_logic;
      RESET : in std_logic;
      SET : in std_logic;
      D : in std_logic;
      EN : in std_logic;
      Q : out std_logic
);
END component;

signal D2, D1, D0, Q2, Q1, Q0 : std_logic;

begin

-- Flip-flop's
Flip_Flop_Q2: FFD port map( CLK => clk, RESET => reset, 
SET => '0', D => D2, EN => '1', Q => Q2);
Flip_Flop_Q1: FFD port map( CLK => clk, RESET => reset, 
SET => '0', D => D1, EN => '1', Q => Q1);
Flip_Flop_Q0: FFD port map( CLK => clk, RESET => reset, 
SET => '0', D => D0, EN => '1', Q => Q0);

-- Generate Next State
D2 <= ((not(Q0) and not(Q1) and Q2 and start and not(step)) or 
(Q0 and Q1 and not(Q2) and not(step)));

D1 <= ((not(Q0) and not(Q1) and Q2 and start and step) or 
(not(Q2) and Q0 and step) or (not(Q0) and Q1 and not(Q2)));

D0 <= ((not(Q2) and not(Q1) and not(Q0) and start) or 
(Q0 and not(Q1) and not(Q2) and not(step)) or 
(Q0 and not(Q2) and Q1 and step) or(not(Q0) and Q1 and not(Q2)));

-- Generate outputs
EN_Reg<=not(Q2) and Q1 and not(Q0);
RST_Reg<=not(Q2) and not(Q1) and not(Q0);
Dec_Mux<=not(Q2) and Q1 and Q0;
EN_ACC<=not(Q2) and Q1 and not(Q0);
RST_ACC<=not(Q2) and not(Q1) and Q0;

end structural;