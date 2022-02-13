LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity vaga is
	port( s_signal : in std_logic;
		clk_signal : in std_logic;
		rst_signal : in std_logic;
		led_signal : out std_logic;
		wrt_signal : out std_logic;
		data_signal : out std_logic_vector(7 downto 0)
		);
end vaga;

architecture RTL of vaga is

	type state is (st_init, st_vazio, st_cheio, st_tudo);
	signal atual_state, proximo_state: state;
	--signal sig_signal : std_logic;
	signal set_signal, set_signal2: std_logic;
	signal sig_signal: std_logic_vector(27 downto 0);
	signal cont_signal : std_logic_vector(7 downto 0);
		
	component contador
	port
	(
		ck : in std_logic;
		set : in std_logic;
		cont : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component cont2s
	port
	(
		Ck2 : in std_logic;
    set2 : in std_logic;
	 sig2 : out std_logic_vector(27 downto 0)
	);
	end component;
begin
	counter:contador port map(ck => clk_signal, set => set_signal, cont => cont_signal);
	count2:cont2s port map(ck2 => clk_signal, set2 => set_signal2, sig2 => sig_signal);
	process (s_signal, atual_state, clk_signal, sig_signal) is
		variable aux : integer;
	begin
		--aux := 0;
		case atual_state is
				when st_init =>
					set_signal <= '0';
					set_signal2 <= '0';
					wrt_signal <= '0';
					proximo_state <= st_vazio;
					led_signal <= '0';
				when st_vazio =>
					wrt_signal <= '0';
					set_signal2 <= '0';
					set_signal <= '0';
					led_signal <= '0';
					if(s_signal = '0') then
						proximo_state <= st_cheio;
					else
						proximo_state <= st_vazio;
					end if;
				when st_cheio =>
					set_signal <= '1';
					set_signal2 <= '0';
					wrt_signal <= '0';
					led_signal <= '1';
					if(s_signal = '1') then
						proximo_state <= st_tudo;
					else
						proximo_state <= st_cheio;
					end if;
				when st_tudo =>
					set_signal <= '1';
					set_signal2 <= '1';
					wrt_signal <= '1';
					led_signal <= '0';
					if (sig_signal < x"0000190") then
						proximo_state <= st_tudo;
					else
						proximo_state <= st_vazio;
					end if;
				when others =>
			end case;
	end process;
	process(clk_signal, rst_signal)
	begin
		if(rst_signal = '1') then
			atual_state <= st_init;
		elsif (rising_edge(clk_signal)) then
			case proximo_state is
				when st_init =>
					atual_state <= st_init;
				when st_vazio =>
					atual_state <= st_vazio;
				when st_cheio =>
					atual_state <= st_cheio;
				when st_tudo =>
					atual_state <= st_tudo;
				when others =>
			end case;
		end if;
	end process;
	data_signal <= cont_signal;
end RTL;
		