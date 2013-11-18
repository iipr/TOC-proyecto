--------------------------------------------------------------------------------
-- Felipe Machado Sanchez
-- Departameto de Tecnologia Electronica
-- Universidad Rey Juan Carlos
-- http://gtebim.es/~fmachado
--
-- Pinta barras para la XUPV2P

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 
use WORK.DCSE_PKG.ALL;

entity pinta_barras is
  Port (
    -- In ports
    visible      : in std_logic;
    pxl_num      : in unsigned(c_nb_pxls-1 downto 0);
    line_num     : in unsigned(c_nb_lines-1 downto 0);
    -- Out ports
    red          : out std_logic_vector(c_nb_red-1 downto 0);
    green        : out std_logic_vector(c_nb_green-1 downto 0);
    blue         : out std_logic_vector(c_nb_blue-1 downto 0)
  );
end pinta_barras;

architecture behavioral of pinta_barras is

  constant c_bar_width : natural := 64;

begin

  P_pinta: Process (visible, pxl_num, line_num)
  begin
    red   <= (others=>'0');
    green <= (others=>'0');
    blue  <= (others=>'0');
    if visible = '1' then
      -- una linea blanca en los bordes
      if pxl_num = 0 OR pxl_num = c_pxl_visible -1 OR
        line_num=0 OR line_num= c_line_visible -1 then
        red   <= (others=>'1');
        green <= (others=>'1');
        blue  <= (others=>'1');
      elsif line_num >= 256 and line_num < 256 + c_bar_width then 
        -- esto solo tiene sentido para la XUPV2P
        red   <= std_logic_vector(pxl_num(c_nb_red-1 downto 0));
        green <= std_logic_vector(pxl_num(c_nb_green-1 downto 0));
        blue  <= std_logic_vector(pxl_num(c_nb_blue-1 downto 0));
        if pxl_num >= 256 then
          red   <= std_logic_vector(pxl_num(c_nb_red-1 downto 0));
          green <= std_logic_vector(resize(255-pxl_num(7 downto 0),c_nb_green));
          blue  <= (others=>'0');
        end if;
        if pxl_num >= 512 then -- rayas horizontales
          red   <= (others=>not(line_num(0))); 
          green <= (others=>not(line_num(0))); 
          blue  <= (others=>not(line_num(0))); 
        end if;
      elsif line_num >= 256+c_bar_width and line_num < 256 + 2*c_bar_width then 
        red   <= std_logic_vector(resize(255 - pxl_num(7 downto 0),c_nb_red));
        green <= std_logic_vector(resize(255 - pxl_num(7 downto 0),c_nb_green));
        blue  <= std_logic_vector(resize(255 - pxl_num(7 downto 0),c_nb_blue));
        if pxl_num >= 256 then
          red  <=std_logic_vector(resize(255 - pxl_num(7 downto 0),c_nb_red)); 
          green<=(others=>'0');
          blue <= std_logic_vector(pxl_num(c_nb_blue-1 downto 0));
        end if;
        if pxl_num >= 512 then  -- puntos
          red   <= (others=>pxl_num(0) xor line_num(0));
          green <= (others=>pxl_num(0) xor line_num(0));
          blue  <= (others=>pxl_num(0) xor line_num(0));
        end if;
      elsif pxl_num/c_bar_width = 0 then
        -- columna 0 sera blanca, columna 1 negra, ...
        red   <= (others=>not(pxl_num(0))); 
        green <= (others=>not(pxl_num(0))); 
        blue  <= (others=>not(pxl_num(0))); 
      elsif pxl_num/c_bar_width = 1 then
        --blanco
        red   <= (others=>'1');
        green <= (others=>'1');
        blue  <= (others=>'1');
      elsif pxl_num/c_bar_width = 2 then
        --amarillo
        red   <= (others=>'1');
        green <= (others=>'1');
        blue  <= (others=>'0');
      elsif pxl_num/c_bar_width = 3 then
        --cian
        red   <= (others=>'0');
        green <= (others=>'1');
        blue  <= (others=>'1');
      elsif pxl_num/c_bar_width = 4 then
        --verde
        red   <= (others=>'0');
        green <= (others=>'1');
        blue  <= (others=>'0');
      elsif pxl_num/c_bar_width = 5 then
        --magenta
        red   <= (others=>'1');
        green <= (others=>'0');
        blue  <= (others=>'1');
      elsif pxl_num/c_bar_width = 6 then
        --rojo
        red   <= (others=>'1');
        green <= (others=>'0');
        blue  <= (others=>'0');
      elsif pxl_num/c_bar_width = 7 then
        --azul
        red   <= (others=>'0');
        green <= (others=>'0');
        blue  <= (others=>'1');
      elsif pxl_num/c_bar_width = 8 then
        --negro
        red   <= (others=>'0');
        green <= (others=>'0');
        blue  <= (others=>'0');
      else
        -- columna 639 sera blanca, 638 negra, ...
        red   <= (others=>pxl_num(0)); 
        green <= (others=>pxl_num(0)); 
        blue  <= (others=>pxl_num(0)); 
      end if;
    end if;
  end process;
  
  
end Behavioral;

