with Hardware;
with Estimation;
with Control;

with RP.Device;

procedure Skye_Flight_Core is

begin

    Hardware.Initialize;

    loop
        
        Hardware.Schedule;
        Estimation.Schedule;
        Control.Schedule;

        RP.Device.Timer.Delay_Milliseconds (500);

    end loop;

end Skye_Flight_Core;
