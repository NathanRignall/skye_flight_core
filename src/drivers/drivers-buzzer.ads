with RP.GPIO;
with RP.PWM;

package Drivers.Buzzer is

    type Buzzer (Control_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    type Frequency_Type is range 100 .. 20_000;

    procedure Initialize (This : Buzzer);

    procedure Set_Frequency (This : in out Buzzer; Frequency : Frequency_Type);

    procedure Set_Power (This : in out Buzzer; Power : Boolean);

private

    procedure Update (This : Buzzer);

    type Buzzer (Control_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        PWM_Point : RP.PWM.PWM_Point := RP.PWM.To_PWM (Control_Point.all);

        Frequency : Frequency_Type := 500;
        Power     : Boolean := False;
    end record;

end Drivers.Buzzer;
