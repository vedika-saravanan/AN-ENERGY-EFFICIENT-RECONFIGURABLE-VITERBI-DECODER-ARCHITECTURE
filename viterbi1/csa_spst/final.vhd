library ieee ;
    
    use ieee.std_logic_1164.all     ;
    use ieee.std_logic_arith.all    ;
    use ieee.std_logic_unsigned.all ;
    
    
    entity csa is
      port (  
              clk : in std_logic ;
              in1, in2,in3,in4 : in std_logic_vector (8 downto 0);
              csa_err          : out std_logic
           );
   end csa ;
   
   
    Architecture behav of csa is
     
      component add is 
    
        port (
      
             a : in std_logic_vector ( 7 downto 0 ) ;
             b : in std_logic_vector ( 7 downto 0 ) ;               
             x : out std_logic_vector ( 7 downto 0 ) 
             
        ) ;
        end component ;
      
      component mux1 is 
    
        port (
              a, b    : in std_logic_vector ( 7 downto 0 ) ; 
              sel     : in std_logic  ;               
              op      : out std_logic_vector ( 7 downto 0 )  
         ) ;
           
         end  component;   
        
       component sub is 
    
        port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;               
             output : out std_logic_vector ( 8 downto 0 ) 
             
        ) ;
        
end  component ;

    component xorr is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic ;               
             outp : out std_logic
        ) ;
        
    end component ;

  component reg is 
      
       port (
              
              clk    : in std_logic ; 
              input  : in std_logic_vector ( 8 downto 0 ) ;
              output : out std_logic_vector ( 8 downto 0 ) 
              
            ) ;
            
  end component ;
   
  component xor1 is 
    
      port (
      
             in1 : in std_logic_vector ( 7 downto 0 ) ;
             in2 : in std_logic_vector ( 7 downto 0 ) ;             
             outp : out std_logic
        ) ;
        
end component ;
      
      signal rout1,rout2,rout3, rout4,rout5,rout6,sout,aout1,aout2  : std_logic_vector ( 8 downto 0 ) ;
      signal mout1,mout2  : std_logic_vector ( 7 downto 0 ) ;
      signal xout1,xout2,xout3,xout4,xout5,xout6,xout7 : std_logic ;
    
      begin
        
         u0 : reg port map ( clk, in1, rout1 );
         u1 : reg port map ( clk, in2, rout2 );
         u2 : sub port map ( rout1(8 downto 1), rout2(8 downto 1),sout );
         u3 : mux1 port map ( rout1(8 downto 1), rout2(8 downto 1), sout(8), mout1 );
         u4 : mux1 port map ( rout1(8 downto 1), rout2(8 downto 1), sout(8), mout2 );
         u5 : xor1 port map ( mout1, mout2, xout1 );
         
         u6 : xorr port map ( rout1(8 downto 1), rout1(0), xout2)  ;
         u7 : xorr port map ( rout2(8 downto 1), rout2(0), xout3)  ;
         
         u8 : reg port map ( clk, in3, rout3 );
         u9 : reg port map ( clk, in4, rout4 );
         
         u10 : xorr port map ( rout3(8 downto 1), rout3(0), xout4)  ;
         u11 : xorr port map ( rout4(8 downto 1), rout4(0), xout5)  ;
         
         u12 : add port map ( mout1,rout3(8 downto 1), aout1(8 downto 1) );
         u13 : add port map ( mout1,rout4(8 downto 1), aout2(8 downto 1) );
         
         aout1(0) <= aout1(8) xor aout1(7) xor aout1(6) xor aout1(5) xor aout1(4) xor aout1(3) xor aout1(2) xor aout1(1);
         aout2(0) <= aout2(8) xor aout2(7) xor aout2(6) xor aout2(5) xor aout2(4) xor aout2(3) xor aout2(2) xor aout2(1);
         
         u14 : reg port map ( clk, aout1, rout5 );
         u15 : reg port map ( clk, aout2, rout6 );
         
         u16 : xorr port map ( rout5(8 downto 1), rout5(0), xout6)  ;
         u17 : xorr port map ( rout6(8 downto 1), rout6(0), xout7)  ;
         
         csa_err <= xout1 or xout2 or xout3 or xout4 or xout5 or xout6 or xout7 ;
         
 end behav ;      
 