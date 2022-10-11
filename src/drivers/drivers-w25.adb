with HAL;
use type HAL.UInt8;

package body Drivers.W25 is

    procedure Initialize (This : W25) is
    begin

        This.CS.Configure(RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);

        This.CS_Deselect;

    end Initialize;

    procedure CS_Select (This: W25) is
    begin
    
        This.CS.Clear;

    end CS_Select;

    procedure CS_Deselect (This: W25) is
    begin

        This.CS.Set;

    end CS_Deselect;

    procedure Wait_Done (This: W25) is

        Data: HAL.SPI.SPI_Data_8b := ( 16#05#, 0 );
        Status : HAL.SPI.SPI_Status;

    begin

        loop

            This.CS_Select;

            This.Port.Transmit(Data, Status);

            This.Port.Receive(Data, Status);

            exit when Data(1) = 0;

        end loop;

    end Wait_Done;

end Drivers.W25;
