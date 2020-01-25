library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity poisson is
port(gclk,rst: in std_logic;
rout: out std_logic);
end entity;
architecture x of poisson is
signal feedback,dclk0,dclk1: std_logic;
signal lfsr0,rbits: unsigned(31 downto 0);
signal dfreq: unsigned (6 downto 0);
signal hcout: unsigned (11 downto 0);
begin

process(gclk)
begin
  if rising_edge(gclk) then
    if dfreq="1100100" then
      dfreq<="0000000";
      dclk0<='1';
    else
      dfreq<=dfreq+1;
      dclk0<='0';
    end if;
  end if;
end process;

process(gclk)
begin
  if rising_edge(gclk) then
    if hcout="110010000000" then
      hcout<="000000000000";
      dclk1<='1';
    else
      hcout<=hcout+1;
      dclk1<='0';
    end if;
  end if;
end process;

process(dclk0,rst)
begin
  if rst='0' then
    lfsr0<="00000000000000000000000000100000";
  else
    if rising_edge(dclk0) then
      lfsr0(31)<=feedback;
      lfsr0(30)<=lfsr0(31);
      lfsr0(29)<=lfsr0(30) xor feedback;
      lfsr0(28)<=lfsr0(29);
      lfsr0(27)<=lfsr0(28);
      lfsr0(26)<=lfsr0(27);
      lfsr0(25)<=lfsr0(26) xor feedback;
      lfsr0(24)<=lfsr0(25) xor feedback;
      lfsr0(23)<=lfsr0(24);
      lfsr0(22)<=lfsr0(23);
      lfsr0(21)<=lfsr0(22);
      lfsr0(20)<=lfsr0(21);
      lfsr0(19)<=lfsr0(20);
      lfsr0(18)<=lfsr0(19);
      lfsr0(17)<=lfsr0(18);
      lfsr0(16)<=lfsr0(17);
      lfsr0(15)<=lfsr0(16);
      lfsr0(14)<=lfsr0(15);
      lfsr0(13)<=lfsr0(14);
      lfsr0(12)<=lfsr0(13);
      lfsr0(11)<=lfsr0(12);
      lfsr0(10)<=lfsr0(11);
      lfsr0(9)<=lfsr0(10);
      lfsr0(8)<=lfsr0(9);
      lfsr0(7)<=lfsr0(8);
      lfsr0(6)<=lfsr0(7);
      lfsr0(5)<=lfsr0(6);
      lfsr0(4)<=lfsr0(5);
      lfsr0(3)<=lfsr0(4);
      lfsr0(2)<=lfsr0(3);
      lfsr0(1)<=lfsr0(2);
      lfsr0(0)<=lfsr0(1);
    end if;
  end if;
end process;

process(dclk1)
begin
  if rising_edge(dclk1) then
    rbits<=lfsr0;
  end if;
end process;

process(rbits)
begin
  if rbits<="00000000010000011000100100110111" then
    rout<='1';
  else
    rout<='0';
  end if;
end process;

feedback<=lfsr0(0);

end x;
