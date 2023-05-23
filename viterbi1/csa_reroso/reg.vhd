library ieee ;
    
    use ieee.std_logic_1164.all     ;
    use ieee.std_logic_arith.all    ;
    use ieee.std_logic_unsigned.all ;
    
    
   entity reg is 
      
       port (
              
              clk    : in std_logic ; 
              input  : in std_logic_vector ( 8 downto 0 ) ;
              output : out std_logic_vector ( 8 downto 0 ) 
              
            ) ;
            
   end reg ;
 
 
 architecture behav of reg is 
 
 begin
     
     process ( clk )
         
         begin
             
            if clk'event and clk='1' then
                 
                 output(8 downto 1) <= input(8 downto 1) ;
                 output(0)          <= input(0);
                 
            end if ;
         
    end process ;
     
    
end behav ;