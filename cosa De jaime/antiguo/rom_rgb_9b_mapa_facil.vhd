------- ROM creada automaticamente por ppm2rom -----------
------- Felipe Machado -----------------------------------
------- Departamento de Tecnologia Electronica -----------
------- Universidad Rey Juan Carlos ----------------------
------- http://gtebim.es ---------------------------------
----------------------------------------------------------
--------Datos de la imagen -------------------------------
--- Fichero original    : mapa_facil-BWppm.ppm 
--- Filas    : 256 
--- Columnas : 1024 
----------------------------------------------------------
--------Codificacion de la memoria------------------------
--- Palabras de 9 bits
--- De cada palabra hay 3 bits para cada color : "RRRGGGBBB" 512 colores



------ Puertos -------------------------------------------
-- Entradas ----------------------------------------------
--    clk  :  senal de reloj
--    addr :  direccion de la memoria
-- Salidas  ----------------------------------------------
--    dout :  dato de 9 bits de la direccion addr (un ciclo despues)



library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
entity ROM_RGB_9b_mapa_facil is
  port (
    clk					  : in  std_logic;   -- reloj
    addr, addr_munyeco : in  std_logic_vector(18-1 downto 0);
    dout, dout_munyeco : out std_logic
  );
end ROM_RGB_9b_mapa_facil;

architecture BEHAVIORAL of ROM_RGB_9b_mapa_facil is
  signal addr_int, addr_munyeco_int  : natural range 0 to 2**18-1;
  
begin

  addr_int <= TO_INTEGER(unsigned(addr));
  addr_munyeco_int <= TO_INTEGER(unsigned(addr_munyeco));


  P_ROM: process (clk)
  begin
	 if clk'event and clk='0' then
		--dout <= filaimg(addr_int);
		--dout_munyeco <= filaimg(addr_munyeco_int);
		dout <= '0';
		dout_munyeco <= '0';
	 end if;
  end process;

end BEHAVIORAL;

