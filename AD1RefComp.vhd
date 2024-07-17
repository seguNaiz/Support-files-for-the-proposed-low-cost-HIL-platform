--------------------------------------------------------------------------------
--    AD1 Reference Component
--------------------------------------------------------------------------------
--    Desription    :    This file is the VHDL code for a PMOD-AD1 controller.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;    -- vhdl-linter-disable-line not-declared
use IEEE.STD_LOGIC_UNSIGNED.all; -- vhdl-linter-disable-line not-declared

entity AD1RefComp is
    port (

        --General usage
        CLK  : in std_logic; -- System Clock (50MHz)
        NRST : in std_logic;

        --Pmod interface signals
        D1      : in std_logic;
        D2      : in std_logic;
        CLK_OUT : out std_logic;
        CS      : out std_logic;

        --User interface signals
        DATA1 : out std_logic_vector(11 downto 0);
        DATA2 : out std_logic_vector(11 downto 0);
        START : in std_logic;
        DONE  : out std_logic

    );
end AD1RefComp;

architecture AD1 of AD1RefComp is
    type states is (Idle,
        ShiftIn,
        SyncData);
    signal current_state : states;

    signal control1       : std_logic_vector(3 downto 0); -- vhdl-linter-disable-line unused
    signal control2       : std_logic_vector(3 downto 0); -- vhdl-linter-disable-line unused
    signal temp1          : std_logic_vector(15 downto 0);
    signal temp2          : std_logic_vector(15 downto 0);
    signal clk_div        : std_logic_vector(1 downto 0);
    signal clk_counter    : std_logic_vector(27 downto 0);
    signal shiftCounter   : std_logic_vector(3 downto 0) := "0000";
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
                    --temp1        <= temp1(14 downto 0) & d1;
                    --temp2        <= temp2(14 downto 0) & d2;
                    control1     <= temp1(14 downto 11);
                    control2     <= temp2(14 downto 11);
                    DATA1        <= temp1(11 downto 0);
                    DATA2        <= temp2(11 downto 0);
                elsif (enShiftCounter = '1' or START = '1') then
                    temp1        <= temp1(14 downto 0) & d1;
                    temp2        <= temp2(14 downto 0) & d2;
                    shiftCounter <= shiftCounter + '1';
                end if;
            end if;
        end if;
    end process;

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
            CS             <= '1';
            enParalelLoad  <= '0';
        elsif current_state = ShiftIn then
            enShiftCounter <= '1';
            DONE           <= '0';
            CS             <= '0';
            enParalelLoad  <= '0';
        else --if current_state = SyncData then
            enShiftCounter <= '0';
            DONE           <= '0';
            CS             <= '1';
            enParalelLoad  <= '1';
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
                            current_state <= ShiftIn;
                        end if;
                    when ShiftIn =>
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

end AD1;
