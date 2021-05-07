library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 

entity cruz is
    Port (columnas: in std_logic_vector(9 downto 0);
          filas: in std_logic_vector(9 downto 0);
          visible: in std_logic;
          
          red: out std_logic_vector(c_nb_red-1 downto 0);
          green: out std_logic_vector(c_nb_green-1 downto 0);
          blue: out std_logic_vector(c_nb_blue-1 downto 0)
    );
end cruz;

architecture Behavioral of cruz is
    
   -- constant ancho_de_barra :natural:= 80; --"0001000000"; --64
    

begin

    P_pin: process (visible,columnas,filas)
    begin
    red   <= (others=>'0');
    green  <= (others=>'0');
    blue   <= (others=>'0');
        if(visible='1') then
        
            if((columnas>= 0 and columnas <= 640) and (filas >= 0 and filas <= 10)) then -- 1era seccion
                red <= (others=>'1');
                green <= (others=>'0');
                blue <= (others=>'0');
                elsif((columnas>= 0 and columnas <= 640) and (filas >= 455 and filas <= 465)) then -- 1era seccion
                                                            red <= (others=>'1');
                                                            green <= (others=>'0');
                                                            blue <= (others=>'0');
            ----------------------------------------------------------------------empieza 2da seccion
            elsif(filas >= 11 and filas <= 230) then
                if(columnas >=0 and columnas <=10) then
                    red <= (others=>'1');
                    green <= (others=>'0');
                    blue <= (others=>'0');
                elsif(columnas >=11 and columnas <=310) then
                    red <= (others=>'0');
                    green <= (others=>'0');
                    blue <= (others=>'1');
                elsif(columnas >=311 and columnas <=320) then
                    red <= (others=>'1');
                    green <= (others=>'0');
                    blue <= (others=>'0');
                elsif(columnas >=321 and columnas <=629) then
                    red <= (others=>'0');
                    green <= (others=>'0');
                    blue <= (others=>'1');
                elsif(columnas >=630 and columnas <=640) then
                    red <= (others=>'1');
                    green <= (others=>'0');
                    blue <= (others=>'0');
                end if;
            ----------------------------------------------------------------------termina 2da seccion 
                elsif((columnas>= 0 and columnas <= 640) and (filas >= 231 and filas <= 240)) then  
                                red <= (others=>'1');
                                green <= (others=>'0');
                                blue <= (others=>'0');
                                ---------------------------
                elsif(filas >= 241 and filas <= 454) then
                            if(columnas >=0 and columnas <=10) then
                                red <= (others=>'1');
                                green <= (others=>'0');
                                blue <= (others=>'0');
                            elsif(columnas >=11 and columnas <=310) then
                                red <= (others=>'0');
                                green <= (others=>'0');
                                blue <= (others=>'1');
                            elsif(columnas >=311 and columnas <=320) then
                                red <= (others=>'1');
                                green <= (others=>'0');
                                blue <= (others=>'0');
                            elsif(columnas >=321 and columnas <=629) then
                                red <= (others=>'0');
                                green <= (others=>'0');
                                blue <= (others=>'1');
                            elsif(columnas >=630 and columnas <=640) then
                                red <= (others=>'1');
                                green <= (others=>'0');
                                blue <= (others=>'0');
                            end if;
                
                                            
            end if;
    
    
        end if;
    end process;
            
end Behavioral;
