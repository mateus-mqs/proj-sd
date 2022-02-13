library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;
 
ENTITY tb_estacionamento IS
END tb_estacionamento;
 
ARCHITECTURE behavior OF tb_estacionamento IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
component estacionamento 
	port( s: in std_logic_vector(5 downto 0);
			clock : in std_logic;
			rst : in std_logic;
			l : out std_logic_vector(5 downto 0);
			led1 : out std_logic_vector(6 downto 0);
			led2 : out std_logic_vector(6 downto 0);
			led3 : out std_logic_vector(6 downto 0);
			w : inout std_logic_vector(5 downto 0)
			
		);
end component;

	signal clk              : std_logic;
	signal Sens : std_logic_vector(5 downto 0);
	signal Le1, Le2, Le3: std_logic_vector(6 downto 0);
	signal Leds: std_logic_vector(5 downto 0);
	signal reset : std_logic;
	signal auxdabliu : std_logic_vector(5 downto 0);
 
BEGIN
	-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
DUT: estacionamento
    port map(
			s => Sens,
			clock => clk,
			rst => reset,
			l => Leds,
			led1 => Le1,
			led2 => Le2,
			led3 => Le3,
			w => auxdabliu);

------------------------------------------------
----------------- processo para gerar o sinal de clock 
------------------------------------------------------------------------------------		
        PROCESS    -- clock process for clock
        BEGIN
            WAIT for 5 ns;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (1 ms - (1 ms * 0.5));
                clk <= '1';
                WAIT FOR (1 ms * 0.5);
            END LOOP CLOCK_LOOP;
        END PROCESS;
	
Sens(5) <= '1';
Sens(4) <= '1';
Sens(3) <= '1';
Sens(2) <= '1';
Sens(1) <= '1';
Sens(0) <= '1', '0' after 1 sec, '1' after 4 sec;
reset <= '0';
END;
