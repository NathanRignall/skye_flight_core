with RP.GPIO;
with RP.PWM;

package Drivers.Motor is

    type Motor
       (GPIO_Point_1 : access RP.GPIO.GPIO_Point;
        GPIO_Point_2 : access RP.GPIO.GPIO_Point)
    is
       tagged private;

    type Speed_Type is range 0 .. 100;
    type Mode_Type is (Off, Forward, Backward, Break);

    procedure Initialize (This : Motor);

    procedure Set_Speed (This : in out Motor; Speed : Speed_Type);

    procedure Set_Mode (This : in out Motor; Mode : Mode_Type);

private

    procedure Update (This : Motor);

    type Motor
       (GPIO_Point_1 : access RP.GPIO.GPIO_Point;
        GPIO_Point_2 : access RP.GPIO.GPIO_Point)
    is
    tagged record
        PWM_Point_1 : RP.PWM.PWM_Point := RP.PWM.To_PWM (GPIO_Point_1.all);
        PWM_Point_2 : RP.PWM.PWM_Point := RP.PWM.To_PWM (GPIO_Point_2.all);

        Speed : Speed_Type := 0;
        Mode  : Mode_Type := Off;
    end record;

end Drivers.Motor;
