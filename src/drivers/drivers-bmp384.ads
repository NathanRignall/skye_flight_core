with HAL;
with HAL.I2C;

package Drivers.BMP384 is

    type BMP384 (Port : HAL.I2C.Any_I2C_Port; Address : HAL.I2C.I2C_Address) is
       tagged private;

    procedure Initialize (This : BMP384);

    function Get_Chip_ID ( This : BMP384 ) return HAL.UInt8;

private

    type BMP384 (Port : HAL.I2C.Any_I2C_Port; Address : HAL.I2C.I2C_Address) is
    tagged record
        null;
    end record;

end Drivers.BMP384;
