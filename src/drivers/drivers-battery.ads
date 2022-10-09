with RP.GPIO;
with RP.ADC;

package Drivers.Battery is

    type Battery (Measure_Point: access RP.GPIO.GPIO_Point) is
       tagged private;

    procedure Initialize (This : Battery);

    function Measure (This : Battery) return Integer;

private

    type Battery (Measure_Point: access RP.GPIO.GPIO_Point) is
    tagged record
        ADC_Channel : RP.ADC.ADC_Channel :=  RP.ADC.To_ADC_Channel (Measure_Point.all);
    end record;

end Drivers.Battery;
