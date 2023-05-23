library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
    
    entity xor1 is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;
             
             outp : out std_logic
        ) ;
        
end xor1 ;


architecture behav of xor1 is 
 
 
 
   begin
      
      
       process ( in1, in2 )
       
       begin
       
           if in1 = in2 then
           
              outp <=  '0' ;
              
           else
           
             outp <=  '1' ;
             
       end if ;
       
   end process ; 
   
   end behav ;