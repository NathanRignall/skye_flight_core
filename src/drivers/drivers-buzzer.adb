
package body Drivers.Buzzer is

    procedure Initialize (This : Buzzer) is
    begin

        This.Control_Point.Configure
           (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.PWM);

        RP.PWM.Set_Frequency (This.PWM_Point.Slice, 1_000_000);
        RP.PWM.Enable (This.PWM_Point.Slice);

        This.Update;

    end Initialize;

    procedure Update (This : Buzzer) is
        Interval : RP.PWM.Period;
        Duty_Cycle : RP.PWM.Period;
    begin

        if This.Power then

            Interval := RP.PWM.Period (1_000_000 / Integer (This.Frequency));
            RP.PWM.Set_Interval (This.PWM_Point.Slice, Interval);

            Duty_Cycle :=  RP.PWM.Period ( Integer(Interval) / 2 );
            RP.PWM.Set_Duty_Cycle (This.PWM_Point.Slice, This.PWM_Point.Channel, Duty_Cycle);

        else

            RP.PWM.Set_Interval (This.PWM_Point.Slice, 10_000);
            RP.PWM.Set_Duty_Cycle (This.PWM_Point.Slice, This.PWM_Point.Channel, 0);

        end if;

    end Update;

    procedure Set_Frequency (This : in out Buzzer; Frequency : Frequency_Type) is
    begin

        This.Frequency := Frequency;
        This.Update;

    end Set_Frequency;

    procedure Set_Power (This : in out Buzzer; Power : Boolean) is
    begin

        This.Power := Power;
        This.Update;

    end Set_Power;

end Drivers.Buzzer;
