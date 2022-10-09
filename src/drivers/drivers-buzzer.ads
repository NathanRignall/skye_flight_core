with RP.GPIO;
with RP.PWM;

package Drivers.Buzzer is

    type Buzzer (GPIO_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    procedure Initialize (This : Buzzer);

private

    type Buzzer (GPIO_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        PWM_Point : RP.PWM.PWM_Point := RP.PWM.To_PWM (GPIO_Point.all);
    end record;

end Drivers.Buzzer;
