library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity add is
port(
      
      a,b  : in std_logic_vector(7 downto 0);     
       x   : out std_logic_vector(7 downto 0)
      
  );
end add;


architecture behav_add of add is 

signal close,carr_ctrl,sign,c_lsp : std_logic;
signal sum_lsp : std_logic_vector(3 downto 0);

function fulladder(op1,op2,cin: in std_logic) return std_logic_vector is
  variable output : std_logic_vector(1 downto 0);
begin
	output:="00";
     output(0):=op1 xor op2 xor cin;
	output(1):=(op1 and op2)or(op1 and cin)or(op2 and cin); 
return output;
end fulladder;

function add1(op1,op2 : in std_logic_vector(3 downto 0);cin: in std_logic) return std_logic_vector is
 variable output : std_logic_vector(4 downto 0);
begin
	output(1 downto 0):=fulladder(op1(0),op2(0),cin);
	output(2 downto 1):=fulladder(op1(1),op2(1),output(1));
	output(3 downto 2):=fulladder(op1(2),op2(2),output(2));
	output(4 downto 3):=fulladder(op1(3),op2(3),output(3));		
 return output;
end add1;


function detectionlogic  (a,b : in std_logic_vector(3 downto 0);C_L : in std_logic) return std_logic_vector is
    variable close_clk : std_logic:='1';
    variable rst_n     : std_logic:='0';
    variable Adec_nor,Adec_and,Bdec_nor,Bdec_and : std_logic;
    variable q1,q2,q3,q4,q5,q6,q7,q8,q9,q10 : std_logic;
    variable output : std_logic_vector(4 downto 0);
 begin
      
      
 --Adec_nor:=(((A(7) NOR A(6)) NOR (A(5) NOR A(4))) NOR ((A(3) NOR A(2)) NOR (A(1) NOR A(0))));
 Adec_nor:=(NOT(A(3) OR A(2) OR A(1) OR A(0)));
 Adec_and:=(A(3) AND A(2) AND A(1) AND A(0));

 --Bdec_nor:=(((B(7) NOR B(6)) NOR (B(5) NOR B(4))) NOR ((B(3) NOR B(2)) NOR (B(1) NOR B(0))));
 Bdec_nor:=(NOT(B(3) OR B(2) OR B(1) OR B(0)));
 Bdec_and:=(B(3) AND B(2) AND B(1) AND B(0));


q1:=(Adec_nor or Adec_and);
q2:=(Adec_and or Bdec_and);
q3:=(Adec_and xor Bdec_and xor C_L );
q4:=(Adec_and and Bdec_and and C_L );
q5:=(Bdec_nor or Bdec_and);
q6:=not(C_L);
q7:=q2 and q6;
q8:=q1 nand q5;
q9:=(q1 and q3 and q5);
q10:=(q4 or q7);


--output(0):=r4 or C_M;


if close_clk='1' then
    if rst_n='0' then
        output(4):=q8;   
        output(3):=q9;
        output(2):=q10; 
    end if;
end if;

output(1):=Adec_and;
output(0):=Bdec_and;

return output;
end detectionlogic;

function latch(ab : in std_logic_vector(3 downto 0);CL : in std_logic) return std_logic_vector is
  variable output : std_logic_vector(3 downto 0);
begin
	
   
   output(3):=ab(3) and CL;
   output(2):=ab(2) and CL;
   output(1):=ab(1) and CL;
   output(0):=ab(0) and CL;
   
	
return output;
end latch;

function sign_ext(s : in std_logic_vector(3 downto 0);CL,SG,CAR_CT : in std_logic) return std_logic_vector is
  variable temp : std_logic;
  variable output : std_logic_vector(3 downto 0);
begin
	
	temp:=not(CL) and SG;
	
	output(3):=s(3) or temp;
	output(2):=s(2) or temp;
	output(1):=s(1) or temp;
	output(0):=s(0) or CAR_CT;
	
	
	
return output;
end sign_ext;

	
begin

process(a,b)
   variable temp1 : std_logic_vector(4 downto 0);
   variable temp2 : std_logic_vector(4 downto 0);
   variable temp3 : std_logic_vector(3 downto 0);
   variable temp4 : std_logic_vector(3 downto 0);
   variable temp5 : std_logic_vector(4 downto 0);
   variable temp6 : std_logic_vector(3 downto 0);
   
   variable c,r1,r2,r3,r4 : std_logic;
   
begin


    
temp1:=add1(a(3 downto 0),b(3 downto 0),'0');
sum_lsp<=temp1(3 downto 0);
c_lsp<=temp1(4);

temp2:=detectionlogic(a(7 downto 4),b(7 downto 4),temp1(4));
close<=temp2(4);
sign<=temp2(3);
carr_ctrl<=temp2(2);

temp3:=latch(a(7 downto 4),temp2(4));

temp4:=latch(b(7 downto 4),temp2(4));

c:=temp2(4) and temp1(4);

temp5:=add1(temp3,temp4,c);

temp6:=sign_ext(temp5(3 downto 0),temp2(4),temp2(3),temp2(2));

r1:=temp2(1) or temp2(0);
r2:=temp2(1) and temp2(0);
r3:=r1 and temp1(4);
r4:=r2 or r3;

--cout<=r4 or temp5(4);

x<=temp6(3 downto 0) & temp1(3 downto 0);

end process;

end behav_add;