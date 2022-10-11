with HAL;
with HAL.SPI;
with RP.GPIO;

package Drivers.W25 is

    -- should be switched to HAL
    type W25 (Port : HAL.SPI.Any_SPI_Port; CS: access RP.GPIO.GPIO_Point) is
       tagged private;

    procedure Initialize (This : W25);

    --  procedure Read_Page;

    --  procedure Write_Page;

    --  procedure Write_Enable;

    --  procedure Erase_Sector;

private

    procedure CS_Select (This : W25);

    procedure CS_Deselect (This : W25);

    procedure Wait_Done (This : W25);

    type W25 (Port : HAL.SPI.Any_SPI_Port; CS: access RP.GPIO.GPIO_Point) is
    tagged record
        null;
    end record;

end Drivers.W25;
