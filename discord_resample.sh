#!/bin/bash

# create two null sinks, one takes apps to share => recorded, other recorded + mic => discord
pactl load-module module-null-sink sink_name=Combined_Output sink_properties=device.description=Combined_Output
pactl load-module module-null-sink sink_name=Recorded_Sink sink_properties=device.description=Recorded_Sink

# loopback mic to output sink
pactl load-module module-loopback source=alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_201610-00.mono-fallback sink=Combined_Output
# loopback recording sink to output sink AND to actual system output
pactl load-module module-loopback source=Recorded_Sink.monitor sink=Combined_Output
pactl load-module module-loopback source=Recorded_Sink.monitor sink=alsa_output.pci-0000_0d_00.3.iec958-stereo

# in pavu set any applications you wanna share the audio of to playback through RECORDED_SINK,
# and in recording set WEBRTC to combined audio
