LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity reg1bit is
port(
x : in std_logic;
clk : in std_logic;
RST : in std_logic;
EN : in std_logic;
xout : out std_logic
);
end reg1bit;

architecture structural of reg1bit is
component FFD is
PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
END component;

begin
T0: FFD port map(CLK => clk, RESET => RST, SET => '0', D => x, EN => EN, Q => xout);


end structural;