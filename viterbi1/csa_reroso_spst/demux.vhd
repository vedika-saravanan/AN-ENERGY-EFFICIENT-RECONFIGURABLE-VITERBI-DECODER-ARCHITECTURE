library ieee ;
    
    use ieee.std_logic_1164.all ;
    use ieee.std_logic_arith.all ;
    
    
   entity demux is 
    
      port (
              a       : in std_logic_vector ( 7 downto 0 ) ; 
              sel     : in std_logic  ;               
              op1,op2      : out std_logic_vector ( 7 downto 0 )  
         ) ;
           
   end demux ;
   
   
   architecture behav of demux is 
   
   begin
       
       process ( a, sel )
       
       begin
       
           if sel = '0' then
               
              op1 <= a;              
              
           else
           
              op2 <= a ;
             
           end if ;
       
   end process ;
   
 end behav ;        
        
