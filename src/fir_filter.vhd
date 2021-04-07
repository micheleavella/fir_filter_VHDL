library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity
entity fir_filter_4 is
port (
	clk 			: in  std_logic;								-- clock
	data_in 		: in  std_logic_vector(7 downto 0);				-- data input
    data_valid 		: in std_logic;									-- 1 when reciver is reading																
	data_out    	: out std_logic_vector(7 downto 0);				-- out of reciver
	--transmit		: out std_logic:='0';
     
    -- coefficients
    coeff_0 : in  signed(8 downto 0);	--9 bits
    coeff_1 : in  signed(8 downto 0);
    coeff_2 : in  signed(8 downto 0);
    coeff_3 : in  signed(8 downto 0)
    );
     
end fir_filter_4;


--architecture
architecture rtl of fir_filter_4 is
	--numbers in memory
	signal x_0   :signed(7 downto 0) := (others => '0'); 
	signal x_1   :signed(7 downto 0) := (others => '0'); 
	signal x_2   :signed(7 downto 0) := (others => '0'); 
	signal x_3   :signed(7 downto 0) := (others => '0'); 

	--signals for prods
	signal p_0   :signed(16 downto 0) := (others => '0'); 	-- 9bits x 8bits = 17bits
	signal p_1   :signed(16 downto 0) := (others => '0'); 
	signal p_2   :signed(16 downto 0) := (others => '0'); 
	signal p_3   :signed(16 downto 0) := (others => '0');

	--signals for sums 
	signal s_01   :signed(17 downto 0) := (others => '0'); 	-- 17bits x 17bits = 18bits
	signal s_23   :signed(17 downto 0) := (others => '0'); 
	
	--tot sum
	signal y :signed(18 downto 0) := (others => '0'); 		-- 18bits x 18bits = 19bits

	--tot out
	signal tot_out   :std_logic_vector(7 downto 0) := (others => '0'); 

		
	signal read  :std_logic:='1';							-- 1 if we have already read the number, 0 if not
	--signal t  :std_logic:='0';							

	signal t_count: signed(3 downto 0) := (others => '0');
--begin processes
begin
	
reading : process(clk)
	begin
		if rising_edge(clk) then
			if (data_valid = '0' and read ='0') then		-- new number
				x_3<=x_2;
				x_2<=x_1;
				x_1<=x_0;
				x_0<=signed(data_in);
				read <= '1';
				data_out<= tot_out;
			end if;
			if data_valid = '1' then read <= '0'; end if;	-- if the reciver si reading a new number is coming 
		end if;	

	end process reading;


prod : process(clk)
	begin
		if rising_edge(clk) then
			p_0<=x_0*(coeff_0);				
			p_1<=x_1*(coeff_1);				
			p_2<=x_2*(coeff_2);				
			p_3<=x_3*(coeff_3);
		end if;	

	end process prod;

sum1 : process(clk)
	begin
		if rising_edge(clk) then
			s_01<=resize(p_0, 18)+resize(p_1, 18);
			s_23<=resize(p_2, 18)+resize(p_3, 18);
		end if;	

	end process sum1;

sum2 : process(clk)
	begin
		if rising_edge(clk) then
			y<=resize(s_01, 19)+resize(s_23, 19);
		end if;	

	end process sum2;


output : process(clk)
	begin
		if rising_edge(clk) then
			tot_out<=std_logic_vector(resize(shift_right(y,11),8));		--from 19 to 8 bits and from signed to logic_vector 
		end if;	

	end process output;
	
end rtl;
