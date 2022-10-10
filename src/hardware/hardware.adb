with RP.Clock;
with RP.GPIO;
with RP.ADC;
with RP.PWM;

with HAL;
with HAL.SPI;

with Ada.Text_IO;

package body Hardware is

    procedure Initialize is
    begin

        RP.Clock.Initialize (Skye_Flight.XOSC_Frequency);
        RP.Device.Timer.Enable;
        RP.PWM.Initialize;
        RP.ADC.Enable;

        Skye_Flight.CONSOLE_RX.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.UART);
        Skye_Flight.CONSOLE_TX.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.UART);

        Skye_Flight.RADIO_RX.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.UART);
        Skye_Flight.RADIO_TX.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.UART);

        Skye_Flight.PRIMARY_SDA.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C, Schmitt => True);
        Skye_Flight.PRIMARY_SCL.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C, Schmitt => True);

        Skye_Flight.SECONDARY_SDA.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C, Schmitt => True);
        Skye_Flight.SECONDARY_SCL.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C, Schmitt => True);

        Skye_Flight.FLASH_SCK.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);
        Skye_Flight.FLASH_MOSI.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);
        Skye_Flight.FLASH_MISO.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);
        Skye_Flight.FLASH_CS.Configure
           (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);

        Console.Configure (Config => (Baud => 115_200, others => <>));

        Radio.Configure (Config => (Baud => 115_200, others => <>));

        Primary_Bus.Configure
           (Baudrate     => 100_000,
            Address_Size => RP.I2C_Master.Address_Size_7b);

        Secondary_Bus.Configure
           (Baudrate     => 100_000,
            Address_Size => RP.I2C_Master.Address_Size_7b);

        Flash.Configure
           (Config =>
               (Role      => RP.SPI.Master, Baud => 10_000_000,
                Data_Size => HAL.SPI.Data_Size_8b,
                Polarity  => RP.SPI.Active_Low, Phase => RP.SPI.Rising_Edge,
                Blocking  => True, Loopback => False));

        SD_Card.Configure
           (Config =>
               (Role      => RP.SPI.Master, Baud => 10_000_000,
                Data_Size => HAL.SPI.Data_Size_8b,
                Polarity  => RP.SPI.Active_Low, Phase => RP.SPI.Rising_Edge,
                Blocking  => True, Loopback => False));

        BMP384.Initialize;
        Buzzer.Initialize;
        Servo1.Initialize;
        Servo2.Initialize;
        Servo3.Initialize;
        Servo4.Initialize;
        Motor.Initialize;
        Pyro1.Initialize;
        Pyro2.Initialize;
        Battery.Initialize;

        Motor.Set_Speed (100);
        Motor.Set_Mode (Drivers.Motor.Forward);

    end Initialize;

    procedure Schedule is
    begin

        if Toggle then

            Toggle := False;

            Servo1.Set_Angle (180);
            Servo2.Set_Angle (180);
            Buzzer.Set_Power(True);
            Buzzer.Set_Frequency(2000);

        else

            Toggle := True;

            Servo1.Set_Angle (0);
            Servo2.Set_Angle (0);
            Buzzer.Set_Power(False);
            Buzzer.Set_Frequency(1000);
            
        end if;

    end Schedule;

end Hardware;
