with RP.GPIO;
with RP.ADC;

package Drivers.Pyro is

    type Pyro (Fire_Point: access RP.GPIO.GPIO_Point; Measure_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    procedure Initialize (This : Pyro);

    procedure Fire (This : Pyro; State: Boolean);

    function Measure (This : Pyro) return Boolean;

private

    type Pyro (Fire_Point: access RP.GPIO.GPIO_Point; Measure_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        ADC_Channel : RP.ADC.ADC_Channel :=  RP.ADC.To_ADC_Channel (Measure_Point.all);
    end record;

end Drivers.Pyro;
