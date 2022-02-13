library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity contador is
generic(ClockFrequencyHz : integer := 200); --valor da frequencia
port(
    Ck : in std_logic;
    set : in std_logic;
	 cont : out std_logic_vector(7 downto 0)
	 );
end entity;
 
architecture rtl of contador is
    -- sinal para contagem de periodo de clock
    signal Ticks : integer;
 
begin
    process(Ck) is
		variable seg : unsigned(7 downto 0);
    begin
        if rising_edge(Ck) then
            -- se o set for '0', vai resetar a contagem de  ticks
            if set = '0' then
                Ticks   <= 0;
					 seg := x"00";
            else
                -- verdadeiro a cada segundo
                if Ticks = ClockFrequencyHz - 1 then
                    Ticks <= 0;
							seg := seg + 1;
                else
                    Ticks <= Ticks + 1;
                end if;
 
            end if;
        end if;
		  	cont <= std_logic_vector(seg);

    end process;
end architecture;