with RP.Device;

with HAL;
use type HAL.UInt16;

package body Drivers.Motor is

    procedure Initialize (This : Motor) is
    begin

        This.GPIO_Point_1.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.PWM);
        This.GPIO_Point_2.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.PWM);

        RP.PWM.Set_Frequency (This.PWM_Point_1.Slice, 1_000_000);
        RP.PWM.Set_Frequency (This.PWM_Point_2.Slice, 1_000_000);
        RP.PWM.Set_Interval (This.PWM_Point_1.Slice, 1_000);
        RP.PWM.Set_Interval (This.PWM_Point_2.Slice, 1_000);
        RP.PWM.Enable (This.PWM_Point_1.Slice);
        RP.PWM.Enable (This.PWM_Point_2.Slice);

        This.Update;

    end Initialize;

    procedure Update (This : Motor) is
    begin

        case This.Mode is

            when Off =>
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_1.Slice, This.PWM_Point_1.Channel, 0);
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_2.Slice, This.PWM_Point_2.Channel, 0);
            when Forward =>
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_1.Slice, This.PWM_Point_1.Channel, 1_000 - RP.PWM.Period (This.Speed * 10));
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_2.Slice, This.PWM_Point_2.Channel, 1_000);
            when Backward =>
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_1.Slice, This.PWM_Point_1.Channel, 1_000);
                RP.PWM.Set_Duty_Cycle
                    (This.PWM_Point_2.Slice, This.PWM_Point_2.Channel, 1_000 - RP.PWM.Period (This.Speed * 10));
            when Break =>
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_1.Slice, This.PWM_Point_1.Channel, 1_000);
                RP.PWM.Set_Duty_Cycle
                   (This.PWM_Point_2.Slice, This.PWM_Point_2.Channel, 1_000);

        end case;

    end Update;

    procedure Set_Speed (This : in out Motor; Speed : Speed_Type) is
    begin
        This.Speed := Speed;
        This.Update;
    end Set_Speed;

    procedure Set_Mode (This : in out Motor; Mode : Mode_Type) is
    begin
        This.Mode := Mode;
        This.Update;
    end Set_Mode;

end Drivers.Motor;
