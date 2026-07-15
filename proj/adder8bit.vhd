library ieee;
use ieee.std_logic_1164.all;

entity adder8bit is
port(

      A  : in std_logic_vector(7 downto 0);
      B  : in std_logic_vector(7 downto 0);
      Ci : in std_logic;
      S  : out std_logic_vector(7 downto 0);
      C0 : out std_logic

);
end adder8bit;

architecture structural of adder8bit is
component adder4bit is
port (
      A  : in std_logic_vector(3 downto 0);
      B  : in std_logic_vector(3 downto 0);
      Ci : in std_logic;
      S  : out std_logic_vector(3 downto 0);
      C0 : out std_logic
);
end component;


signal carry,C0_S: std_logic;
signal A_signal1,A_signal2,B_signal2,B_signal1,S_signal1:std_logic_vector(3 downto 0);
signal S_signal2 : std_logic_vector(3 downto 0);

begin
A_signal1 <= (A(3) & A(2) & A(1) & A(0));
A_signal2 <= (A(7) & A(6) & A(5) & A(4));
B_signal1 <= (B(3) & B(2) & B(1) & B(0));
B_signal2 <= (B(7) & B(6) & B(5) & B(4));
U1 : adder4bit port  map (A=>A_signal1,B=>B_signal1,S=>S_signal1,Ci=>'0',C0=>carry);
U2 : adder4bit port map (A=>A_signal2,B=>B_signal2,S=>S_signal2,Ci=>carry,C0=>C0_S);
S<= (S_signal2(3) & S_signal2(2) & S_signal2(1) & S_signal2(0) & S_signal1(3) 
& S_signal1(2) & S_signal1(1) & S_signal1(0) );
C0 <= C0_S;
end structural;
