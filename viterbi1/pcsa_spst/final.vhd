library ieee ;
    
    use ieee.std_logic_1164.all     ;
    use ieee.std_logic_arith.all    ;
    use ieee.std_logic_unsigned.all ;
    
    
    entity pcsa is
      port (  
              clk : in std_logic ;
              in1, in2,in3,in4 : in std_logic_vector (8 downto 0);
              csa_err          : out std_logic
           );
   end pcsa ;
   
   
    Architecture behav of pcsa is
     
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
      
      signal rout1,rout2,rout3, rout4,rout5,rout6,sout  : std_logic_vector ( 8 downto 0 ) ;
      signal aout1,aout2,aout3,aout4,mout1,mout2,mout3,mout4  : std_logic_vector ( 7 downto 0 ) ;
      signal xout1,xout2,xout3,xout4,xout5,xout6,xout7,xout8 : std_logic ;
    
      begin
        
         u0 : reg port map ( clk, in1, rout1 );
         u1 : reg port map ( clk, in2, rout2 );
         u2 : reg port map ( clk, in3, rout3 );
         u3 : reg port map ( clk, in4, rout4 );
         
         u4 : sub port map ( rout1(8 downto 1), rout2(8 downto 1),sout );
         
         u5 : add port map ( rout1(8 downto 1),rout3(8 downto 1), aout1);
         u6 : add port map ( rout2(8 downto 1),rout3(8 downto 1), aout2);
         u7 : add port map ( rout1(8 downto 1),rout4(8 downto 1), aout3);
         u8 : add port map ( rout2(8 downto 1),rout4(8 downto 1), aout4);
         
         u9 : mux1 port map ( aout1, aout2, sout(8), mout1 );
         u10 : mux1 port map ( aout3, aout4, sout(8), mout2 );
         u11 : mux1 port map ( aout1, aout2, sout(8), mout3 );
         u12 : mux1 port map ( aout2, aout4, sout(8), mout4 );
         
         u13 : xorr port map ( rout1(8 downto 1), rout1(0), xout1)  ;
         u14 : xorr port map ( rout2(8 downto 1), rout2(0), xout2)  ;
         u15 : xorr port map ( rout3(8 downto 1), rout3(0), xout3)  ;
         u16 : xorr port map ( rout4(8 downto 1), rout4(0), xout4)  ;
         
         
         rout5(0) <= mout3(7) xor mout3(6) xor mout3(5) xor mout3(4) xor mout3(3) xor mout3(2) xor mout3(1) xor mout3(0) ;
         rout6(0) <= mout4(7) xor mout4(6) xor mout4(5) xor mout4(4) xor mout4(3) xor mout4(2) xor mout4(1) xor mout4(0) ;
         rout5(8 downto 1) <= mout3;
         rout6(8 downto 1) <= mout4;
         
         u17 : xor1 port map ( mout1, mout3, xout5 );
         u18 : xor1 port map ( mout2, mout4, xout6 );
         
         u19 : xorr port map ( mout3, rout5(0), xout7)  ;
         u20 : xorr port map ( mout4, rout6(0), xout8)  ;
         
        
         csa_err <= xout1 or xout2 or xout3 or xout4 or xout5 or xout6 or xout7 or xout8 ;
         
 end behav ;      
 