library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 

entity barras is
    Port (columnas: in std_logic_vector(9 downto 0);
          filas: in std_logic_vector(9 downto 0);
          visible: in std_logic;
          
          red: out std_logic_vector(c_nb_red-1 downto 0);
          green: out std_logic_vector(c_nb_green-1 downto 0);
          blue: out std_logic_vector(c_nb_blue-1 downto 0)
    );
end barras;

architecture Behavioral of barras is
    
    constant ancho_de_barra :natural:= 80; --"0001000000"; --64
    

begin

    P_pinta: process (visible,columnas,filas)
    begin
    red   <= (others=>'0');
    green  <= (others=>'0');
    blue   <= (others=>'0');
    if(visible='1') then
        if (columnas >=0 and columnas < ancho_de_barra)  then --blanco
            red<= "1111";
            green <= "1111";
            blue <="1111";
        elsif (columnas >=ancho_de_barra and columnas < ancho_de_barra*2) then --amarillo
            red<= "1111";
            green <= "1111";
            blue <="0000";
        elsif (columnas >=ancho_de_barra*2 and columnas < ancho_de_barra*3) then--cian
             red<= "0000";
             green <= "1111";
             blue <="1111";
        elsif (columnas >=ancho_de_barra*3 and columnas < ancho_de_barra*4) then --verde
                 red<= "0000";
                 green <= "1111";
                 blue <="0000";
        elsif (columnas >=ancho_de_barra*4 and columnas < ancho_de_barra*5) then --morado
                     red<= "1111";
                     green <= "0000";
                     blue <="1111"; 
        elsif (columnas >=ancho_de_barra*5 and columnas < ancho_de_barra*6 ) then--rojo
                         red<= "1111";
                         green <= "0000";
                         blue <="0000";  
        elsif (columnas >=ancho_de_barra*6 and columnas < ancho_de_barra*7 ) then--azul
                             red<= "0000";
                             green <= "0000";
                             blue <="1111";   
        elsif (columnas >=ancho_de_barra*7 and columnas < ancho_de_barra*8 ) then --negro
                                 red<= "0000";
                                 green <= "0000";
                                 blue <="0000";  
        end if;
        end if;
        end process;
            
end Behavioral;
