library ieee ;    
    use ieee.std_logic_1164.all     ;
    use ieee.std_logic_arith.all    ;
    use ieee.std_logic_unsigned.all ;
    
    
   entity rights_rot is 
      
       port (              
             
              input  : in std_logic_vector ( 7 downto 0 ) ;
              output : out std_logic_vector ( 7 downto 0 ) 
              
            ) ;
            
   end rights_rot ;
 
 
 architecture behav of rights_rot is 
 
 begin
     
     process ( input )
         
         begin             
                            
                 output <= '0' & input(7 downto 1);
                 --output <=  input(0) & input(7 downto 1);                 
                                  
                   
    end process ;
     
    
end behav ;

