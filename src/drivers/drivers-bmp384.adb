
package body Drivers.BMP384 is

    procedure Initialize (This : BMP384) is
    begin

        null;

    end Initialize;

    function Get_Chip_ID (This : BMP384) return HAL.UInt8 is
      use type HAL.I2C.I2C_Status;
      Data   : HAL.I2C.I2C_Data (1 .. 1);
      Status : HAL.I2C.I2C_Status;
    begin
      This.Port.Mem_Read
         (Addr          => This.Address,
          Mem_Addr      => HAL.UInt16 (16#00#),
          Mem_Addr_Size => HAL.I2C.Memory_Size_8b,
          Data          => Data,
          Status        => Status,
          Timeout       => 1000);

      if Status /= HAL.I2C.Ok then
         return 77;
      end if;
      
      return Data(1);
    end Get_Chip_ID;

end Drivers.BMP384;
