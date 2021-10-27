# Printer documentation

This doucment contains information about the printers setup and its wiring.

At the moment of writing, the Voron is a 300mm 2.4. model having a clockwork. Ths Hotend consist of
a E3D V6 clone from Amazon.

Bed is equipped with a 235mm/\500W heater from Keenovo and an additional 3mm threaded thermistor to have more consistant readings on the bed temperature.

As a controller I'm running the Duet3 mini +5 / 2x expansion.
LCD is ....

## Drives

The Z-Drives and extruder are all connected directly to the mini 5+ Duex-Board, A-Drive, B-Drive are connected to the 2x expansion.

| Drive    | Connector |
|:--------:|:---------:|
| Z0       | P0        |
| Z1       | P1        |
| Z2       | P2        |
| Z3       | P3        |
| Extruder | P4        |
|  A       | P5 (x2)   |
|  B       | P6 (x2)   |

Z-Drives are numbered clockwise beginning at the front left corner

```
|-----|-----|
|  1  |  2  |
|-----+-----|
|  0  |  3  |
| ----+-----|
    Front
```

**Attention, when you're flipping over the printer to do electronic motor positions a slighly different !!!**

*** Not editied below ***

## Thermistors and Heaters (Thermal Section)
In line 70 of [config.g](../rrf-config/sys/config.g) the thermal section starts configuring all the heaters and thermosensors.
At first the boards/chips built-in thermal sensore is configured. I measured a difference of 8°K right against room temperature right after switching
on the device. So this is corrected by a M912 command.

Thermistor of the heat pad is connected to the bed temperture port, the second bed thermistor is connected to E1. If you don't use two sensors you can use the single thermistor section which
is commented out in the config.

The heater is connected to the pad connector (H0). I set the PWM frequency to 10Hz. From my impression there is no need to stress the SSR as
the pad heating process is softened by the printing plate anyway.

As I'm using a 600W heat pad I reduced it to 60% via PWM to avoid warping.

Hotend and its thermistor is connected to the appropriate ports for E0.

A DHT22 is connected to the SPI bus of the duex board to check for chambers temperature and humidity.

## Fans
The hotend cooling fan is connected to fan0 and the PWM frequency is set to 20Hz. It is configured to be activated once the hotend temperature exceeds 60°C.

The part cooling fan is connected to fan2 (fan1 seems to bee out of order on my board). PWM frequency is set to 20Hz, too.

At the moment only one additional fan is running and cooling the electronics. It is connected to the duex board which is configured
to supply 12V. The fan is alway on.

## Endstops and Probe
Probe is connected to zprobe.in, only using ground and data from the header. 24v is injected into the probe directly from power connector.
Endstops use their respective connectors on the duet board.
