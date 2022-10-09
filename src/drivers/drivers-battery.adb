with RP.Device;

with HAL;
use type HAL.UInt12;

package body Drivers.Battery is

    procedure Initialize (This : Battery) is
    begin

        This.Measure_Point.Configure (RP.GPIO.Analog);

        RP.ADC.Configure (This.ADC_Channel);

    end Initialize;

    function Measure (This : Battery) return Integer is
        Microvolts   : RP.ADC.Microvolts;
    begin

        Microvolts := RP.ADC.Read_Microvolts(This.ADC_Channel, 3_300_000);

        return Integer(Microvolts) * 5;

    end Measure;

end Drivers.Battery;
