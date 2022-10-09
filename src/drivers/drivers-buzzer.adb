with RP.Device;

package body Drivers.Buzzer is

    procedure Initialize (This : Buzzer) is
    begin

        This.GPIO_Point.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.PWM);

        RP.PWM.Set_Frequency (This.PWM_Point.Slice, 1_000_000);
        RP.PWM.Set_Interval (This.PWM_Point.Slice, 2_000);
        RP.PWM.Set_Duty_Cycle
           (This.PWM_Point.Slice, This.PWM_Point.Channel, 200);
        RP.PWM.Enable (This.PWM_Point.Slice);

        RP.Device.Timer.Delay_Milliseconds (200);
        RP.PWM.Set_Interval (This.PWM_Point.Slice, 1_000);

        RP.Device.Timer.Delay_Milliseconds (200);
        RP.PWM.Set_Interval (This.PWM_Point.Slice, 300);

        RP.Device.Timer.Delay_Milliseconds (200);
        RP.PWM.Set_Duty_Cycle
           (This.PWM_Point.Slice, This.PWM_Point.Channel, 0);

    end Initialize;

end Drivers.Buzzer;
