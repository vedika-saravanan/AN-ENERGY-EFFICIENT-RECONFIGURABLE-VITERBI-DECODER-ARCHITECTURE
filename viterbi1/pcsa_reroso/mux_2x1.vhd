library ieee ;
    
    use ieee.std_logic_1164.all ;
    use ieee.std_logic_arith.all ;
    
    
   entity mux1 is 
    
      port (
              a, b    : in std_logic_vector ( 7 downto 0 ) ; 
              sel     : in std_logic  ; 
              
              op      : out std_logic_vector ( 7 downto 0 )  
         ) ;
           
   end mux1 ;
   
   
   architecture behav of mux1 is 
   
   begin
       
       process ( a, b, sel )
       
       begin
       
           if sel = '0' then
           
              op <=  a ;
              
           else
           
             op <=  b ;
             
       end if ;
       
   end process ;
   
 end behav ;        
        