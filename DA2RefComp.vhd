--------------------------------------------------------------------------------
--    DA2 Reference Component
--------------------------------------------------------------------------------
--    Desription    :    This file is the VHDL code for a PMOD-DA2 controller.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;    -- vhdl-linter-disable-line not-declared
use IEEE.STD_LOGIC_UNSIGNED.all; -- vhdl-linter-disable-line not-declared

entity DA2RefComp is
   port (

      --General usage
      CLK  : in std_logic; -- System Clock (50MHz)
      NRST : in std_logic;

      --Pmod interface signals
      D1      : out std_logic;
      D2      : out std_logic;
      CLK_OUT : out std_logic;
      nSYNC   : out std_logic;

      --User interface signals
      DATA1 : in std_logic_vector(11 downto 0);
      DATA2 : in std_logic_vector(11 downto 0);
      START : in std_logic;
      DONE  : out std_logic

   );
end DA2RefComp;

architecture DA2 of DA2RefComp is
   --      control constant: Normal Operation
   constant control : std_logic_vector(3 downto 0) := "0000";

   type states is (Idle,
      ShiftOut,
      SyncData);
   signal current_state : states;
   -- signal next_state    : states;

   signal temp1          : std_logic_vector(15 downto 0);
   signal temp2          : std_logic_vector(15 downto 0);
   signal clk_div        : std_logic_vector(1 downto 0);
   signal clk_counter    : std_logic_vector(27 downto 0);
   signal shiftCounter   : std_logic_vector(3 downto 0);
   signal enShiftCounter : std_logic;
   signal enParalelLoad  : std_logic;

begin

   ------------------------------------------------------------------------------------
   --
   -- Title      : Clock Divider
   --
   ------------------------------------------------------------------------------------

   clock_divide : process (clk)
   begin
      if (clk = '1' and clk'event) then
         if nrst = '0' then
            clk_counter <= "0000000000000000000000000000";
         else
            clk_counter <= clk_counter + '1';
            clk_div     <= clk_div(0) & clk_counter(1);
            clk_out     <= clk_counter(1);
         end if;
      end if;
   end process;
   -----------------------------------------------------------------------------------
   --
   -- Title      : counter
   --
   -----------------------------------------------------------------------------------

   counter : process (clk)
   begin
      if (clk = '1' and clk'event) then
         if (clk_div = "01") then
            if enParalelLoad = '1' then
               shiftCounter <= "0000";
               temp1        <= control & DATA1;
               temp2        <= control & DATA2;
            elsif (enShiftCounter = '1') then
               temp1        <= temp1(14 downto 0) & temp1(15);
               temp2        <= temp2(14 downto 0) & temp2(15);
               shiftCounter <= shiftCounter + '1';
            end if;
         end if;
      end if;
   end process;

   D1 <= temp1(15);
   D2 <= temp2(15);
   ---------------------------------------------------------------------------------
   --
   -- Title      : Finite State Machine
   --
   -----------------------------------------------------------------------------------

   -----------------------------------------------------------------------------------
   --
   -- Title      : OUTPUT_DECODE
   --
   -----------------------------------------------------------------------------------
   OUTPUT_DECODE : process (current_state)
   begin
      if current_state = Idle then
         enShiftCounter <= '0';
         DONE           <= '1';
         nSYNC          <= '1';
         enParalelLoad  <= '1';
      elsif current_state = ShiftOut then
         enShiftCounter <= '1';
         DONE           <= '0';
         nSYNC          <= '0';
         enParalelLoad  <= '0';
      else --if current_state = SyncData then
         enShiftCounter <= '0';
         DONE           <= '0';
         nSYNC          <= '1';
         enParalelLoad  <= '0';
      end if;
   end process;

   -----------------------------------------------------------------------------------
   --
   -- Title      : NEXT_STATE_DECODE
   --
   -----------------------------------------------------------------------------------
   NEXT_STATE_DECODE : process (clk)
   begin
      if (clk = '1' and clk'event) then
         if (clk_div = "01") then

            case (current_state) is
               when Idle =>
                  if START = '1' then
                     current_state <= ShiftOut;
                  end if;
               when ShiftOut =>
                  if shiftCounter = x"F" then
                     current_state <= SyncData;
                  end if;
               when SyncData =>
                  if START = '0' then
                     current_state <= Idle;
                  end if;
               when others =>
                  current_state <= Idle;
            end case;
            
         end if;
      end if;
   end process;
end DA2;
