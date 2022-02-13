library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity cont2s is
generic(ClockFrequencyHz : integer := 200); --valor da frequencia
port(
    Ck2 : in std_logic;
    set2 : in std_logic;
	 sig2 : out std_logic_vector(27 downto 0)
	 );
end entity;
 
architecture rtl of cont2s is
    -- sinal para contagem de periodo de clock
 
begin
    process(Ck2) is
		variable Ticks : unsigned(27 downto 0);
    begin
        if rising_edge(Ck2) then
            -- se o set for '0', vai resetar a contagem de  ticks
            if set2 = '0' then
                Ticks   := x"0000000";
					 --seg := x"00";
            else
                    Ticks := Ticks + 1;
            end if;
        end if;
		  sig2 <= std_logic_vector(Ticks);

    end process;
end architecture;