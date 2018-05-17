library IEEE;
use IEEE.std_logic_1164.all;

entity Flow is	  
	port(FLOW_K : in std_logic_vector(7 downto 0);
			 COM: in std_logic_vector(3 downto 0);
			COND: in std_logic_vector(3 downto 0);
		   CARRY: in std_logic;
		   ZERO : in std_logic;
	COUNTER_LOAD: out std_logic_vector(7 downto 0);
	STACK_POP	: out STD_LOGIC:='0';
	STACK_PUSH  : out STD_LOGIC:='0'; 
	jump,call,returnn: out STD_LOGIC;
			CLK : in STD_LOGIC);
end Flow;
			  	 
architecture FC of Flow is
signal enable: std_logic;
begin
	process(FLOW_K,COM,COND,CLK)
	variable enable:std_logic:='0';
	variable j,c,r :std_logic:='0';
	variable push,pop:std_logic:='0';
	variable AUX_CLK : std_logic:='0';
	variable EN_PUSH :integer range 0 to 2:=0;
	begin
		if(RISING_EDGE(CLK)) then
			AUX_CLK:='1';
		end if;
		if(FALLING_EDGE(CLK)) then
			AUX_CLK:='0';
		end if;
		
		if(COM(3 downto 1)="100") then
			if(COM(0)='0') 
				then enable:='1';
			else
				case COND(3) is
					when '0' => enable:=ZERO  xor COND(2);
					when '1' => enable:=CARRY xor COND(2); --aritmetica booleana
					when others => NULL; 
				end case;
			end if;
			if( enable = '1') then
				--report "DA";
				--if(RISING_EDGE(CLK)) then
--					AUX_CLK:='1';
--				end if;
				
				COUNTER_LOAD<=FLOW_K;         
				case COND(1 downto 0) is
					when "00" =>
							if(pop='1') then
								pop:='0';
								r :='0';
							else
								pop:='1';
								r := '1';
							j := '0';
						 	c := '0';
							end if;
							
					when "01" =>   --jump
						    j := '1';
							c := '0';
							r := '0';
					when "11" =>
							if(push='1') then
								push:='0';
								c   :='0';
							else
								push:='1';
								c := '1';
						   		r := '0';
								j := '0';
							end if;
							--elsif(EN_PUSH=2) then
--								push:='1';
--								EN_PUSH:=0;
--							end if;
--							if(EN_PUSH=1) then
--								c := '1';
--						   		r := '0';
--								j := '0';
--								EN_PUSH:=2;
--							end if;
--							if(AUX_CLK='0' and EN_PUSH =0) then
--								EN_PUSH:=1;
--							end if;
								
					when others =>  
								  -- if(EN_PUSH=2) then
--									   push:= '1';
--									   EN_PUSH:=0;
--								   end if;
				end case;
			else
				r   :='0';
				c   :='0';
				j   :='0';
				pop :='0';
				push:='0';
				--if(push = '1') then 
--					push :='0'; 
--				end if;
			end if; --enable
		else
			r	:='0';
			c	:='0';
			j	:='0';
			pop :='0';
			push:='0';
	--		if(push = '1' and AUX_CLK='1') then 
--				push :='0';
--				EN_PUSH:=0; 
			--end if;
		end if; --com=0;  
	jump<=j;
	call<=c;
	returnn<=r;
	STACK_POP<=pop;
	STACK_PUSH<=push;
	end process;
end;
		
		
		
		



--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use ieee.math_real.all;
--
--entity Flow is	  
--	port(FLOW_K : in std_logic_vector(7 downto 0);
--			 COM: in std_logic_vector(3 downto 0);
--			COND: in std_logic_vector(3 downto 0);
--		   CARRY: in std_logic;
--		   ZERO : in std_logic;
--	COUNTER_LOAD: out std_logic_vector(7 downto 0);
--	STACK_POP	: out STD_LOGIC:='0';
--	STACK_PUSH  : out STD_LOGIC:='0'; 
--	jump,call,returnn: out STD_LOGIC;
--			CLK : in STD_LOGIC);
--end Flow;
--
--architecture Flow_control of Flow is
----signal enable:std_logic;
--begin	 
--	process 
--	--variable enable:std_logic;
--	variable EN_PUSH : std_logic:='0';
--	variable AUX_CLK : std_logic:='0';
--	variable ENABLE  : std_logic:='0';
--	begin
--	if(RISING_EDGE(CLK)) then
--		AUX_CLK:='1';
--	end if;
--	if(FALLING_EDGE(CLK)) then
--		AUX_CLK:='0';
--	end if;	
--	
--	if(AUX_CLK='1') then
--		STACK_PUSH<='0';
--	end if;
--	if(COM(3 downto 1)="100") then
--		if(COM(0)='0') then enable:='1';
--		else
--		case COND(3) is
--			when '0' => enable:=ZERO  xor COND(2);
--			when '1' => enable:=CARRY xor COND(2); --aritmetica booleana
--			when others => 
--		end case;
--		end if;
--		if( enable = '1') then
--			--report "DA";
--			COUNTER_LOAD<=FLOW_K;         
--			case COND(1 downto 0) is
--				when "00" =>  
--							 	if(AUX_CLK='0') then
--									 STACK_POP<='0';
--							    end if;
--								if(AUX_CLK='1') then
--									STACK_POP<='1';
--									returnn <= '1';
--							     	jump <='0';
--								 	call <='0';
--								end if;
--				when "01" => if(AUX_CLK='1') then 
--						    	jump    <= '1';
--							 call    <= '0';
--							 returnn <= '0';
--							 end if;
--				when "11" => 
--					       	if(AUX_CLK='0') then
--								   if(EN_PUSH='1') then
--									   STACK_PUSH<='1';
--									   EN_PUSH:='0';
--								   else
--									   EN_PUSH:='1';
--									end if;
--							end if;
--							if(AUX_CLK='1') then
--									STACK_PUSH<='0';
--									call 	 <= '1';
--						    		returnn  <= '0';
--									jump     <= '0';	
--							end if;
--				when others =>NULL;
--			end case;
--		else
--			returnn<='0';
--			call   <='0';
--			jump   <='0';
--		end if; --enable
--		else
--			returnn<='0';
--			call   <='0';
--			jump   <='0';
--		end if; --com=0;
--	wait on COM,COND,FLOW_K,CLK;
--	end process;
--end Flow_control;	
--

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use ieee.math_real.all;
--
--entity Flow is	  
--	port(FLOW_K : in std_logic_vector(7 downto 0);
--			 COM: in std_logic_vector(3 downto 0);
--			COND: in std_logic_vector(3 downto 0);
--		   CARRY: in std_logic;
--		   ZERO : in std_logic;
--	COUNTER_LOAD: out std_logic_vector(7 downto 0);
--	STACK_POP	: out STD_LOGIC:='0';
--	STACK_PUSH  : out STD_LOGIC:='0'; 
--	jump,call,returnn: out STD_LOGIC;
--			CLK : in STD_LOGIC);
--end Flow;
--
--architecture Flow_control of Flow is
--signal enable:std_logic;
--begin	 
--	process 
--	--variable enable:std_logic;
--	begin
--	if(RISING_EDGE(CLK)) then
--		STACK_PUSH<='0';
--	end if;
--	if(COM(3 downto 1)="100") then
--		if(COM(0)='0') then enable<='1';
--		else
--		case COND(3) is
--			when '0' => enable<=ZERO  xor COND(2);
--			when '1' => enable<=CARRY xor COND(2); --aritmetica booleana
--			when others => 
--		end case;
--		end if;
--		if( enable = '1') then
--			--report "DA";
--			COUNTER_LOAD<=FLOW_K;         
--			case COND(1 downto 0) is
--				when "00" =>  
--							 	if(FALLING_EDGE(CLK)) then
--									 STACK_POP<='0';
--							    end if;
--								if(RISING_EDGE(CLK)) then
--									STACK_POP<='1';
--									returnn <= '1';
--							     jump <='0';
--								 call <='0';
--								end if;
--				when "01" => if(RISING_EDGE(CLK)) then 
--						    	jump    <= '1';
--							 call    <= '0';
--							 returnn <= '0';
--							 end if;
--				when "11" => 
--					       		if(FALLING_EDGE(CLK)) then
--									 STACK_PUSH<='1';
--								end if;
--								if(RISING_EDGE(CLK)) then
--									STACK_PUSH<='0';
--									call 	 <= '1';
--						    		returnn  <= '0';
--									jump     <= '0';	
--							end if;
--				when others =>NULL;
--			end case;
--		else
--			returnn<='0';
--			call   <='0';
--			jump   <='0';
--		end if; --enable
--		else
--			returnn<='0';
--			call   <='0';
--			jump   <='0';
--		end if; --com=0;
--	wait on COM,COND,FLOW_K,ENABLE,CLK;
--	end process;
--end Flow_control;