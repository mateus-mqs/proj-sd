library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity display is
port(
    num_in : in std_logic_vector(7 downto 0);
	 ativa : in std_logic;
	 LED_out1 : out std_logic_vector(6 downto 0);
	 LED_out2 : out std_logic_vector(6 downto 0);
	 LED_out3 : out std_logic_vector(6 downto 0)
	 );
end entity;
 
architecture rtl of display is
		signal nums_out : unsigned(11 downto 0);
		signal num1_out : std_logic_vector(3 downto 0);
		signal num2_out : std_logic_vector(3 downto 0);
		signal num3_out : std_logic_vector(3 downto 0);
		signal num1_out_aux : unsigned(3 downto 0);
		signal num2_out_aux : unsigned(3 downto 0);
		signal num3_out_aux : unsigned(3 downto 0);

 function to_bcd ( bin : unsigned(7 downto 0) ) return unsigned is
		variable i : integer:=0;
		variable bcd : unsigned(11 downto 0) := (others => '0');
		variable bint : unsigned(7 downto 0) := bin;

		begin
		for i in 0 to 7 loop  -- repeating 8 times.
			bcd(11 downto 1) := bcd(10 downto 0);  --shifting the bits.
			bcd(0) := bint(7);
			bint(7 downto 1) := bint(6 downto 0);
			bint(0) :='0';


			if(i < 7 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(3 downto 0) := bcd(3 downto 0) + "0011";
			end if;

			if(i < 7 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(7 downto 4) := bcd(7 downto 4) + "0011";
			end if;

			if(i < 7 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(11 downto 8) := bcd(11 downto 8) + "0011";
			end if;


		end loop;
		return bcd;
	end to_bcd;
begin	
		nums_out <= to_bcd(unsigned(num_in));
		num1_out_aux <= unsigned(nums_out(3 downto 0));
		num2_out_aux <= unsigned(nums_out(7 downto 4));
		num3_out_aux <= unsigned(nums_out(11 downto 8));
   process(num1_out_aux, num2_out_aux, num3_out_aux, ativa) is
	begin
		 if ativa = '0' then
			 LED_out1 <= "1111111";
			 LED_out2 <= "1111111";
			 LED_out3 <= "1111111";
		 else
			 case num1_out_aux is
				 when "0000" => LED_out1 <= "0000001"; -- "0"     
				 when "0001" => LED_out1 <= "1001111"; -- "1" 
				 when "0010" => LED_out1 <= "0010010"; -- "2" 
				 when "0011" => LED_out1 <= "0000110"; -- "3" 
				 when "0100" => LED_out1 <= "1001100"; -- "4" 
				 when "0101" => LED_out1 <= "0100100"; -- "5" 
				 when "0110" => LED_out1 <= "0100000"; -- "6" 
				 when "0111" => LED_out1 <= "0001111"; -- "7" 
				 when "1000" => LED_out1 <= "0000000"; -- "8"     
				 when "1001" => LED_out1 <= "0000100"; -- "9" 
				 when "1010" => LED_out1 <= "0000010"; -- a
				 when "1011" => LED_out1 <= "1100000"; -- b
				 when "1100" => LED_out1 <= "0110001"; -- C
				 when "1101" => LED_out1 <= "1000010"; -- d
				 when "1110" => LED_out1 <= "0110000"; -- E
				 when "1111" => LED_out1 <= "0111000"; -- F
				 when others => LED_out1 <= "1111111"; -- "0"     
			 end case;
			 case num2_out_aux is
				 when "0000" => LED_out2 <= "0000001"; -- "0"     
				 when "0001" => LED_out2 <= "1001111"; -- "1" 
				 when "0010" => LED_out2 <= "0010010"; -- "2" 
				 when "0011" => LED_out2 <= "0000110"; -- "3" 
				 when "0100" => LED_out2 <= "1001100"; -- "4" 
				 when "0101" => LED_out2 <= "0100100"; -- "5" 
				 when "0110" => LED_out2 <= "0100000"; -- "6" 
				 when "0111" => LED_out2 <= "0001111"; -- "7" 
				 when "1000" => LED_out2 <= "0000000"; -- "8"     
				 when "1001" => LED_out2 <= "0000100"; -- "9" 
				 when "1010" => LED_out2 <= "0000010"; -- a
				 when "1011" => LED_out2 <= "1100000"; -- b
				 when "1100" => LED_out2 <= "0110001"; -- C
				 when "1101" => LED_out2 <= "1000010"; -- d
				 when "1110" => LED_out2 <= "0110000"; -- E
				 when "1111" => LED_out2 <= "0111000"; -- F
				 when others => LED_out2 <= "1111111"; -- "0"  
			 end case;
			 case num3_out_aux is
				 when "0000" => LED_out3 <= "0000001"; -- "0"     
				 when "0001" => LED_out3 <= "1001111"; -- "1" 
				 when "0010" => LED_out3 <= "0010010"; -- "2" 
				 when "0011" => LED_out3 <= "0000110"; -- "3" 
				 when "0100" => LED_out3 <= "1001100"; -- "4" 
				 when "0101" => LED_out3 <= "0100100"; -- "5" 
				 when "0110" => LED_out3 <= "0100000"; -- "6" 
				 when "0111" => LED_out3 <= "0001111"; -- "7" 
				 when "1000" => LED_out3 <= "0000000"; -- "8"     
				 when "1001" => LED_out3 <= "0000100"; -- "9" 
				 when "1010" => LED_out3 <= "0000010"; -- a
				 when "1011" => LED_out3 <= "1100000"; -- b
				 when "1100" => LED_out3 <= "0110001"; -- C
				 when "1101" => LED_out3 <= "1000010"; -- d
				 when "1110" => LED_out3 <= "0110000"; -- E
				 when "1111" => LED_out3 <= "0111000"; -- F
				 when others => LED_out3 <= "1111111"; -- "0"  
			 end case;
		 end if;
	end process;
end architecture;