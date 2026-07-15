library ieee;
use ieee.std_logic_1164.all;

entity FA is
    port (
        A : in std_logic;
        B : in std_logic;
        Ci : in std_logic;
        S : out std_logic;
        C0 : out std_logic
    );
end FA;

architecture structural of FA is
component HA is
port (
       A : in std_logic;
       B : in std_logic;
		 S : out std_logic;
       C0 : out std_logic 
);
end component;

signal addAB : std_logic;
signal carry : std_logic_vector(1 downto 0);

begin

    U1 : HA port map ( A => A, B => B, S => addAB, C0 => carry(0));
    U2 : HA port map ( A => addAB, B => Ci, S => S, C0 => carry(1));

    C0 <= carry(0) or carry(1);

end structural;
