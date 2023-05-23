library ieee ;    
use ieee.std_logic_1164.all     ;
use ieee.std_logic_arith.all    ;
use ieee.std_logic_unsigned.all ;
    
    
    entity pcsa_reroso is
      port (  
              clk              : in std_logic ;
              in1,in2,in3,in4  : in std_logic_vector (7 downto 0);
              r1_r2            : in std_logic;
              xout1,xout2      : out std_logic
           );
    end pcsa_reroso ;
   
   
    Architecture behav of pcsa_reroso is
     
      component add is 
    
        port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;               
             output : out std_logic_vector ( 7 downto 0 ) 
             
        ) ;
        end component ;
      
      
      component lefts_rot is 
      
       port (              
             
              input  : in std_logic_vector ( 7 downto 0 ) ;
              output : out std_logic_vector ( 7 downto 0 ) 
              
            ) ;
            
       end component ;
   
       
       component rights_rot is 
      
       port (              
             
              input  : in std_logic_vector ( 7 downto 0 ) ;
              output : out std_logic_vector ( 7 downto 0 ) 
              
            ) ;
            
      end component ;
   
   
      component mux1 is 
    
        port (
              a, b    : in std_logic_vector ( 7 downto 0 ) ; 
              sel     : in std_logic  ;               
              op      : out std_logic_vector ( 7 downto 0 )  
         ) ;
           
         end  component;   
       
       
      component demux is 
    
      port (
              a       : in std_logic_vector ( 7 downto 0 ) ; 
              sel     : in std_logic  ;               
              op1,op2      : out std_logic_vector ( 7 downto 0 )  
         ) ;
           
      end component ;
   
    
       component sub is 
    
        port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;               
             output : out std_logic_vector ( 8 downto 0 ) 
             
        ) ;
        
      end  component ;

    
  component xor1 is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;             
             outp : out std_logic
        ) ;
        
end component ;
      
      signal rout1,rout2,rout3, rout4,rout5,rout6,aout1,aout2,aout3,aout4  : std_logic_vector ( 7 downto 0 ) ;
      signal sout  : std_logic_vector ( 8 downto 0 ) ;
      signal mout1,mout2,mout3,mout4,mout5,mout6,dmout1,dmout2,dmout3,dmout4  : std_logic_vector ( 7 downto 0 ) ;
      
    
      begin
         
         u0 : lefts_rot port map ( in1, rout1 );
         u1 : lefts_rot port map ( in2, rout2 );
         u2 : lefts_rot port map ( in3, rout3 );
         u3 : lefts_rot port map ( in4, rout4 );
         
         u4 : mux1 port map ( in1, rout1, r1_r2, mout1);
         u5 : mux1 port map ( in2, rout2, r1_r2, mout2);
         u6 : mux1 port map ( in3, rout3, r1_r2, mout3);
         u7 : mux1 port map ( in4, rout4, r1_r2, mout4);
        
         u8 : sub port map ( mout1, mout2, sout);
         
         u9  : add port map ( mout1,mout3, aout1);
         u10 : add port map ( mout2,mout3, aout2);
         u11 : add port map ( mout1,mout4, aout3);
         u12 : add port map ( mout2,mout4, aout4);
         
         
         u13 : mux1 port map ( aout1, aout2, sout(8), mout5);
         u14 : mux1 port map ( aout3, aout4, sout(8), mout6);
         
         u15 : demux port map ( mout5, r1_r2, dmout1, dmout2);
         u16 : demux port map ( mout6, r1_r2, dmout3, dmout4);
           
         
         
         u17 : rights_rot port map ( dmout1, rout5 );
         u18 : rights_rot port map ( dmout3, rout6 );
         
         u19 : xor1 port map ( rout5, dmout2, xout1 );
         u20 : xor1 port map ( rout6, dmout4, xout2 ); 
         
         
         
         
        
         
 end behav ;      
 