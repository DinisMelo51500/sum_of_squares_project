LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity datapath is
	port(
	xi: in std_logic_vector(3 downto 0);
	clk: in std_logic;
	EN_Reg,RST_Reg,Dec_Mux,EN_ACC,RST_ACC : in std_logic;
	
	R : out std_logic_vector(7 downto 0);
	CY : out std_logic
	);
	
end datapath;

architecture structural of datapath is

component mux8bit is
	port
	(
		A : in std_logic_vector (7 downto 0);
		B : in std_logic_vector (7 downto 0);
		Dec_Mux: in std_logic;
		Y : out std_logic_vector (7 downto 0)
	);
	
end component;

component X2 is
port(

	X:in std_logic_vector(3 downto 0);
	
	X2X:out std_logic_vector(7 downto 0)
	
);
end component;



component reg4bit is
port(
x : in std_logic_vector(3 downto 0);
clk : in std_logic;
RST : in std_logic;
EN : in std_logic;
xout : out std_logic_vector(3 downto 0)
);
end component;


component adder8bit is
port(

      A  : in std_logic_vector(7 downto 0);
      B  : in std_logic_vector(7 downto 0);
      Ci : in std_logic;
      S  : out std_logic_vector(7 downto 0);
      C0 : out std_logic

);
end component;

component reg8bit is
port(
x8 : in std_logic_vector(7 downto 0);
clk : in std_logic;
RST : in std_logic;
EN : in std_logic;
xout8 : out std_logic_vector(7 downto 0)
);
end component;

signal xout4 : std_logic_vector(3 downto 0);
signal X2X_Signal,R_Signal,S_adder8bit,REG8_OUT : std_logic_vector(7 downto 0);
signal CY_SIGNAL: std_logic;
begin
U1 : reg4bit port map(x=>xi,clk=>clk,RST=>RST_Reg,EN=>EN_Reg,xout=>xout4);

U2 : X2 port map(X=>xout4,X2X=>X2X_Signal);

U3 : adder8bit port map(A=>X2X_Signal,B=>REG8_OUT,Ci=>'0',C0=>CY_SIGNAL,S=>S_adder8bit);

U4 : reg8bit port map(x8=>S_adder8bit,clk=>clk,EN=>EN_ACC,RST=>RST_ACC,xout8=>REG8_OUT);

U5 : mux8bit port map(A=>S_adder8bit,B=>X2X_Signal,Dec_Mux=>Dec_Mux,Y=>R_Signal);

CY <= CY_SIGNAL;
R <= R_Signal;

end structural;