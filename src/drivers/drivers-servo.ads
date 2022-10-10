with RP.GPIO;
with RP.PWM;

package Drivers.Servo is

    type Servo (Control_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    type Angle_Type is range 0 .. 180;

    procedure Initialize (This : Servo);

    procedure Set_Angle (This : in out Servo; Angle: Angle_Type);

private

    procedure Update (This : Servo);

    type Servo (Control_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        PWM_Point : RP.PWM.PWM_Point := RP.PWM.To_PWM (Control_Point.all);
        
        Angle : Angle_Type := 0;
    end record;

end Drivers.Servo;
