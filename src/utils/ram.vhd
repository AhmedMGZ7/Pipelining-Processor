library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ram is
	port(
		clk : in std_logic;
		en : in std_logic;
		we  : in std_logic;
		address : in  std_logic_vector(31 downto 0);
		datain  : in  std_logic_vector(31 downto 0);
		dataout : out std_logic_vector(31 downto 0)
		);
end entity ram;

ARCHITECTURE syncrama OF ram is

	type ram_type is array(0 TO 2**16-1) OF std_logic_vector(15 downto 0);
	signal ram : ram_type;
	
	begin
		process(clk) is
			begin
				if rising_edge(clk) and en = '1' THEN  
					if we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain(31 downto 16);
						ram((to_integer(unsigned(address)))+1) <= datain(15 downto 0);
					else
						dataout(31 downto 16)<= ram(to_integer(unsigned(address)));
						dataout(15 downto 0) <= ram((to_integer(unsigned(address))) +1);
					end if;
				end if;
		end process;
end syncrama;
