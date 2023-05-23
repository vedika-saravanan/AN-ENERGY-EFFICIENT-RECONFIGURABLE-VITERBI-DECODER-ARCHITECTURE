library ieee ;
    
    use ieee.std_logic_1164.all     ;
    use ieee.std_logic_arith.all    ;
    use ieee.std_logic_unsigned.all ;
    
    
   entity lefts_rot is 
      
       port (              
             
              input  : in std_logic_vector ( 7 downto 0 ) ;
              output : out std_logic_vector ( 7 downto 0 ) 
              
            ) ;
            
   end lefts_rot ;
 
 
 architecture behav of lefts_rot is 
 
 begin
     
     process ( input )
         
         begin
             
                            
                 output <= input(6 downto 0) & '0';
                 --output <= input(6 downto 1) & input(7);
                 
                                  
           
         
    end process ;
     
    
end behav ;
