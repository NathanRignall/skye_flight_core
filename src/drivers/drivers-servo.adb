
package body Drivers.Servo is

    procedure Initialize (This : Servo) is
    begin

        This.Control_Point.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.PWM);

        RP.PWM.Set_Frequency (This.PWM_Point.Slice, 1_000_000);
        RP.PWM.Set_Interval (This.PWM_Point.Slice, 20_000);
        RP.PWM.Enable (This.PWM_Point.Slice);

        This.Update;

    end Initialize;

    procedure Update (This : Servo) is
        Duty_Cycle : RP.PWM.Period;
    begin

        Duty_Cycle := RP.PWM.Period (400 + (2_000 * Integer (This.Angle) / 180));
        RP.PWM.Set_Duty_Cycle
           (This.PWM_Point.Slice, This.PWM_Point.Channel, Duty_Cycle);

    end Update;

    procedure Set_Angle (This : in out Servo; Angle : Angle_Type) is
    begin

        This.Angle := Angle;
        This.Update;

    end Set_Angle;

end Drivers.Servo;
