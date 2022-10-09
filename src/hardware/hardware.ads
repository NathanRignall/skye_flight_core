with RP.Device;
with RP.UART;
with RP.I2C_Master;
with RP.SPI;

with Skye_Flight;

with Drivers.BMP384;
with Drivers.Buzzer;
with Drivers.Servo;
with Drivers.Motor;
with Drivers.Pyro;
with Drivers.Battery;

package Hardware is

     Console : RP.UART.UART_Port renames RP.Device.UART_0;
     Radio   : RP.UART.UART_Port renames RP.Device.UART_1;

     Primary_Bus   : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_0;
     Secondary_Bus : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_1;

     Flash   : RP.SPI.SPI_Port renames RP.Device.SPI_0;
     SD_Card : RP.SPI.SPI_Port renames RP.Device.SPI_1;

     BMP384 :
         Drivers.BMP384.BMP384
             (Port => Primary_Bus'Access, Address => 2#1110_1100#);
     Buzzer : Drivers.Buzzer.Buzzer (GPIO_Point => Skye_Flight.BUZZER'Access);

     Servo1 : Drivers.Servo.Servo (GPIO_Point => Skye_Flight.SERVO1'Access);
     Servo2 : Drivers.Servo.Servo (GPIO_Point => Skye_Flight.SERVO2'Access);
     Servo3 : Drivers.Servo.Servo (GPIO_Point => Skye_Flight.SERVO3'Access);
     Servo4 : Drivers.Servo.Servo (GPIO_Point => Skye_Flight.SERVO4'Access);

     Motor :
         Drivers.Motor.Motor
             (GPIO_Point_1 => Skye_Flight.MOTOR_IN1'Access,
              GPIO_Point_2 => Skye_Flight.MOTOR_IN2'Access);

     Pyro1 :
         Drivers.Pyro.Pyro
             (Fire_Point    => Skye_Flight.PYRO1_FIRE'Access,
              Measure_Point => Skye_Flight.PYRO1_MEASURE'Access);
     Pyro2 :
         Drivers.Pyro.Pyro
             (Fire_Point    => Skye_Flight.PYRO2_FIRE'Access,
              Measure_Point => Skye_Flight.PYRO2_MEASURE'Access);

     Battery :
         Drivers.Battery.Battery
             (Measure_Point => Skye_Flight.BATTERY_MEASURE'Access);

     Toggle : Boolean;

     procedure Initialize;

     procedure Schedule;

private

end Hardware;
