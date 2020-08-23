library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeypadLock is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           B1 : in  STD_LOGIC;
           B2 : in  STD_LOGIC;
           B3 : in  STD_LOGIC;
           B4 : in  STD_LOGIC;
           B5 : in  STD_LOGIC;
           locked : out  STD_LOGIC;
			  unlocked: out STD_LOGIC;
           EN : out  STD_LOGIC;
           sevenseg : out  STD_LOGIC_VECTOR (7 downto 0));
end KeypadLock;

architecture Behavioral of KeypadLock is
type statetype is (init, one, two, three, four, unlock);
signal state: statetype;

begin
EN <= '0';
process (reset, clk, B1, B2, B3, B4, B5) begin
if (reset = '0') then
sevenseg <= "11111110";
state <= init;
elsif rising_edge(clk) then
case (state) is

when init =>
unlocked <= '0';
locked <= '1';
if (B2 = '0') then
sevenseg <= "00110010";
state <= one;
elsif (B1 = '0') then
sevenseg <= "10011111";
state <= init;
elsif (B3 = '0') then
sevenseg <= "00010110";
state <= init;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
elsif (B5 = '0') then
sevenseg <= "01010100";
state <= init;
end if;

when one =>
unlocked <= '0';
locked <= '1';
if (B3 = '0') then
sevenseg <= "00010110";
state <= two;
elsif (B1 = '0') then
sevenseg <= "10011111";
state <= init;
elsif (B2 = '0') then
sevenseg <= "00110010";
state <= one;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
elsif (B5 = '0') then
sevenseg <= "01010100";
state <= init;
end if;

when two =>
unlocked <= '0';
locked <= '1';
if (B5 = '0') then
sevenseg <= "01010100";
state <= three;
elsif (B1 = '0') then
sevenseg <= "10011111";
state <= init;
elsif (B2 = '0') then
sevenseg <= "00110010";
state <= init;
elsif (B3 = '0') then
sevenseg <= "00010110";
state <= two;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
end if;

when three =>
unlocked <= '0';
locked <= '1';
if (B1 = '0') then
sevenseg <= "10011111";
state <= four;
elsif (B2 = '0') then
sevenseg <= "00110010";
state <= init;
elsif (B3 = '0') then
sevenseg <= "00010110";
state <= init;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
elsif (B5 = '0') then
sevenseg <= "01010100";
state <= three;
end if;

when four =>
unlocked <= '0';
locked <= '1';
if (B2 = '0') then
sevenseg <= "00110010";
state <= unlock;
elsif (B1 = '0') then
sevenseg <= "10011111";
state <= four;
elsif (B3 = '0') then
sevenseg <= "00010110";
state <= init;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
elsif (B5 = '0') then
sevenseg <= "01010100";
state <= init;
end if;

when unlock =>
locked <= '0';
unlocked <= '1'; 
sevenseg <= "00110010";
if (B2 = '0') then
sevenseg <= "00110010";
state <= unlock;
elsif (B1 = '0') then
sevenseg <= "10011111";
state <= init;
elsif (B3 = '0') then
sevenseg <= "00010110";
state <= init;
elsif (B4 = '0') then
sevenseg <= "10011100";
state <= init;
elsif (B5 = '0') then
sevenseg <= "01010100";
state <= init;
end if;

end case;
end if;
end process;

end Behavioral;

