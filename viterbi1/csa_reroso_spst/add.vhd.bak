library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
    
entity add is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;               
             output : out std_logic_vector ( 7 downto 0 ) 
             
        ) ;
        
end add ;


architecture behav of add is 


function fulladder(op1,op2,cin: in std_logic) return std_logic_vector is
	variable output : std_logic_vector(1 downto 0);
begin
    
	output:="00";
   output(0):=op1 xor op2 xor cin;
	output(1):=(op1 and op2)or(op1 and cin)or(op2 and cin); 
	
return output;
end fulladder;

function add(op1,op2 : in std_logic_vector(7 downto 0);cin: in std_logic) return std_logic_vector is
  	variable output : std_logic_vector(8 downto 0);
begin
    
	output(1 downto 0):=fulladder(op1(0),op2(0),cin);
	output(2 downto 1):=fulladder(op1(1),op2(1),output(1));
	output(3 downto 2):=fulladder(op1(2),op2(2),output(2));
	output(4 downto 3):=fulladder(op1(3),op2(3),output(3));
	output(5 downto 4):=fulladder(op1(4),op2(4),output(4));
	output(6 downto 5):=fulladder(op1(5),op2(5),output(5));
	output(7 downto 6):=fulladder(op1(6),op2(6),output(6));
	output(8 downto 7):=fulladder(op1(7),op2(7),output(7));	
	
return output(7 downto 0);
end add;

begin       
       
        output <= add(in1,in2,'0') ;
        
end behav ;