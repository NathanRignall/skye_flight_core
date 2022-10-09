with RP.GPIO;
with RP.PWM;

package Drivers.Servo is

    type Servo (GPIO_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    type Angle_Type is range 0 .. 180;

    procedure Initialize (This : Servo);

    procedure Set_Angle (This : Servo; Angle: Angle_Type);

private

    type Servo (GPIO_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        PWM_Point : RP.PWM.PWM_Point := RP.PWM.To_PWM (GPIO_Point.all);
    end record;

end Drivers.Servo;
