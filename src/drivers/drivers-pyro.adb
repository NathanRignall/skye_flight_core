with RP.Device;

with HAL;
use type HAL.UInt12;

package body Drivers.Pyro is

    procedure Initialize (This : Pyro) is
    begin

        This.Fire_Point.Configure (RP.GPIO.Output);
        This.Measure_Point.Configure (RP.GPIO.Analog);

        RP.ADC.Configure (This.ADC_Channel);

    end Initialize;

    procedure Fire (This : Pyro; State: Boolean) is 
    begin

        if State then

            This.Fire_Point.Set;

        else

            This.Fire_Point.Clear;

        end if;

    end Fire;

    function Measure (This : Pyro) return Boolean is
        Value   : RP.ADC.Analog_Value;
    begin

        Value := RP.ADC.Read(This.ADC_Channel);

        return Value > 1000;

    end Measure;

end Drivers.Pyro;
