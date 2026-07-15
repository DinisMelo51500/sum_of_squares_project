library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TLAB3 is
	port
	(
		MCLK   : in std_logic;
		Rst    : in std_logic;
		Step   : in std_logic;
		Start  : in std_logic;
		X	   : in std_logic_vector(3 downto 0);
		Cy     : out std_logic;
		sum	   : out std_logic_vector(7 downto 0);
		HEX0, HEX1, HEX2 : out std_logic_vector(7 downto 0)
	);
end TLAB3;

architecture structural of TLAB3 is

component ASM is
port(
    reset       : in std_logic;
    clk         : in std_logic;
    start       : in std_logic;
    step        : in std_logic;
    EN_Reg,RST_Reg,Dec_Mux,EN_ACC,RST_ACC: out std_logic

);
end component;

component reg1bit is
port(
x : in std_logic;
clk : in std_logic;
RST : in std_logic;
EN : in std_logic;
xout : out std_logic
);
end component;

component datapath is
	port(
	xi: in std_logic_vector(3 downto 0);
	clk: in std_logic;
	EN_Reg,RST_Reg,Dec_Mux,EN_ACC,RST_ACC : in std_logic;
	
	R : out std_logic_vector(7 downto 0);
	CY : out std_logic
	);
	
end component;

component decoderHex IS
PORT (	bin: in std_logic_vector(7 downto 0);		
	clear : in std_logic;
	HEX0 : out std_logic_vector(7 downto 0);
	HEX1 : out std_logic_vector(7 downto 0);
	HEX2 : out std_logic_vector(7 downto 0)
);		
END component;

signal EN_Reg_S,RST_Reg_S,Dec_Mux_S,EN_ACC_S,RST_ACC_S,CY_S,CY_Y: std_logic;
signal R_S,HEX0_S,HEX1_S,HEX2_S : std_logic_vector(7 downto 0);
signal stepDE10 : std_logic;
begin
stepDE10<= not(Step);
U0 : ASM port map(reset=>Rst,clk=>MCLK,start=>Start,step=>stepDE10,EN_Reg=>EN_Reg_S,
RST_Reg=>RST_Reg_S,Dec_Mux=>Dec_Mux_S,EN_ACC=>EN_ACC_S,RST_ACC=>RST_ACC_S);
U1 : datapath port map(xi=>X,clk=>MCLK,EN_Reg=>EN_Reg_S,RST_Reg=>RST_Reg_S,Dec_Mux=>Dec_Mux_S,
EN_ACC=>EN_ACC_S,RST_ACC=>RST_ACC_S,R=>R_S,CY=>CY_S);
U2 : decoderHex port map(bin=>R_S,clear=>'0',HEX0=>HEX0_S,HEX1=>HEX1_S,HEX2=>HEX2_S);
U3 : reg1bit port map(x=>CY_S, clk => MCLK, RST=> RST_ACC_S, EN=>CY_S, xout=>CY_Y);
HEX0<=HEX0_S;
HEX1<=HEX1_S;
HEX2<=HEX2_S;
Sum<=R_S; 
Cy<= CY_Y;

end structural;