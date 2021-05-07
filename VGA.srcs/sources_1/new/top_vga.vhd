
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 



entity top_vga is
     Port (clk100: in std_logic;
           --reset: in std_logic; --nivel alto
          
           rojo: out std_logic_vector(3 downto 0);
           verde: out std_logic_vector(3 downto 0);
           azul: out std_logic_vector(3 downto 0);
          
           hsinc: out std_logic;
           vsinc: out std_logic
            );
   
end top_vga;

architecture Behavioral of top_vga is
component VGA_controller is
    Port ( clk50: in std_logic;
           --rst: in std_logic;
        
           col: out std_logic_vector(9 downto 0); --pxl_num Indica el píxel (columna), incluye todos los píxeles, tanto los visibles como los
                                                  -- píxeles de la sincronización y los porches. Va de 0 a 800
           fila: out std_logic_vector(9 downto 0);--Indica la línea (fila), incluye todas las líneas, tanto las visibles como las líneas de
                                                  --la sincronización y los porches. Va de 0 a 520          
           visible: out std_logic; --Indica con un uno si el módulo está enviando un píxel a la pantalla. Si es cero se
                                   --está en el tiempo de sincronismo o porche delantero o trasero (figura 9.4)
          
           hsync: out std_logic;
           vsync: out std_logic
           );
end component;

component cruz is
    Port (columnas: in std_logic_vector(9 downto 0);
          filas: in std_logic_vector(9 downto 0);
          visible: in std_logic;
          red: out std_logic_vector(3 downto 0);
          green: out std_logic_vector(3 downto 0);
          blue: out std_logic_vector(3 downto 0)
    );
end component;

signal column:std_logic_vector(9 downto 0);
signal fila_aux:std_logic_vector(9 downto 0);
signal visible_aux: std_logic;
signal hsinc_aux:std_logic;
signal vsinc_aux:std_logic;
--signal reset_aux: std_logic;
signal clkdiv1: std_logic := '0';

begin

--50mhz
process(clk100)
    begin 
        if(clk100 = '1' and clk100'EVENT) then
            clkdiv1 <= not clkdiv1;
            --new_pxl<=not clkdiv;
        end if;
end process;
-- 50 Mhz

timing1: VGA_controller port map (clk50=> clkdiv1,col=> column,fila=> fila_aux,visible=>visible_aux, hsync=> hsinc_aux,vsync=>vsinc_aux);
picture1: cruz port map(columnas=> column, filas=> fila_aux, visible=> visible_aux,red=> rojo, green=> verde, blue => azul);
hsinc <= hsinc_aux;
vsinc <= vsinc_aux;

end Behavioral;
