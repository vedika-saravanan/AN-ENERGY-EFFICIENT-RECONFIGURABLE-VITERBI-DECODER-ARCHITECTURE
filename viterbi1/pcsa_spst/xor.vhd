library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
    
   entity xorr is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic ;               
             outp : out std_logic
        ) ;
        
   end xorr ;


architecture behav of xorr is 
 
 signal output :  std_logic ;
 
   begin
      
      output <= in1(0) xor in1(1) xor in1(2) xor in1(3) xor in1(4) xor in1(5) xor in1(6) xor in1(7);      
      
            
      outp <= output xor in2 ;  
   
   end behav ;