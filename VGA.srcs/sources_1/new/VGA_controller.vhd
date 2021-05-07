library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 


entity VGA_controller is
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
end VGA_controller;

architecture Behavioral of VGA_controller is
     signal hc, vc : std_logic_vector(9 downto 0):="0000000000"; --sincronia vert y hor, contar 
     signal clkdiv : std_logic := '0';  -- ajustarnos a la freq del vga (pixel freq)
     signal vsenable : std_logic:= '0'; -- Habilitar conteo vertical
     signal new_pxl: std_logic:='1';
     signal visible_pxl: std_logic:='0';
     signal visible_line: std_logic:='0';
     
begin

    --25 MHz pixel frequency contador de ciclos de reloj
    process(clk50)
        begin 
            if(clk50 = '1' and clk50'EVENT) then
                clkdiv <= not clkdiv;
                new_pxl<=not clkdiv;
            end if;
    end process;
    -- end of 25 Mhz
    
    process(clkdiv)  -- contador horizontal (pixeles)
            begin
                if(clkdiv = '1' and clkdiv'EVENT) then 
                    if hc =  c_pxl_total-1 then 
                       hc <= "0000000000";
                       vsenable <= '1';
                       
                    else
                       hc <= hc + 1;
                       vsenable <= '0';
                    end if;
                end if;
        end process;
        
        visible_pxl <= '1' when (hc >= 0 and hc < 640 ) else '0' ; --generar el horizontal sync pulse
        col <= hc;
        hsync <= '0' when (hc>=0 and hc<96) else '1';
        
      process(clkdiv)  -- contador vertical 
              begin
                  if(clkdiv = '1' and clkdiv'EVENT and vsenable='1') then 
                      if vc =  c_line_total-1 then 
                          vc <= "0000000000";
                              
                      else
                          vc <= vc + 1;
                       end if;
                   end if;
               end process;
        fila <= vc;
        visible_line <= '1' when (vc>="0000000000" and vc<480) else '0' ;
        vsync <= '0' when (vc>=479 and vc <482) else '1';
        
        visible <= visible_pxl and visible_line;
        
end Behavioral;