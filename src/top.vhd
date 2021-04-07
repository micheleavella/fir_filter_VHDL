library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is

  port (

    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;

architecture str of top is
  signal clock        : std_logic;
  signal data_to_send : std_logic_vector(7 downto 0) := X"61";
  signal data_valid_out   : std_logic;
  signal busy         : std_logic;
  --signal uart_tx      : std_logic;
  signal ff_out       : std_logic_vector(7 downto 0) := X"61";


  component uart_transmitter is
    port (
      clock        : in  std_logic;
      data_to_send : in  std_logic_vector(7 downto 0);
      data_valid   : in  std_logic;
      busy         : out std_logic;
      uart_tx      : out std_logic);
  end component uart_transmitter;

  component uart_receiver is
    port (
      clock         : in  std_logic;
      uart_rx       : in  std_logic;
      valid         : out std_logic;
      received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;

	component fir_filter_4 is 
		port(
			clk 		: in  std_logic;							
			data_in 	: in  std_logic_vector(7 downto 0);				
			data_valid 	: in  std_logic;													
			data_out    : out std_logic_vector(7 downto 0);
			--transmit    : out std_logic;
					
		 	coeff_0 			 : in  signed(8 downto 0);	
		  	coeff_1 			 : in  signed(8 downto 0);
		  	coeff_2 			 : in  signed(8 downto 0);
		  	coeff_3 			 : in  signed(8 downto 0));
		end component fir_filter_4;	
  
begin  -- architecture str

  uart_receiver_1 : uart_receiver
  port map (
  		clock         => CLK100MHZ,
      	uart_rx       => uart_txd_in,
      	valid         => data_valid_out,
      	received_data => data_to_send);

  ff: fir_filter_4
	port map(
		clk					=> CLK100MHZ, 
		data_valid	  		=> data_valid_out,
		data_in				=> data_to_send,
		coeff_0 			=> "011110101",	
		coeff_1 			=> "011111110",	
		coeff_2 			=> "011111110",	
		coeff_3 			=> "011110101",
		data_out			=> ff_out);
      
  uart_transmitter_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => ff_out,
      data_valid   => data_valid_out,
      busy         => busy,
      uart_tx      => uart_rxd_out);

end architecture str;
