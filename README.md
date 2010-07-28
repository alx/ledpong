# LedPong

## Installation

### RWMidi

1. Open **Terminal** and create a folder for Processing to rwmidi library: _mkdir -p ~/Documents/Processing/librairies/rwmidi/library/_
1. Copy [RWMidi][http://www.ruinwesen.com/support-files/rwmidi/documentation/RWMidi.html] lib to in Processing folder: _cp ./software/lib/rwmidi/rwmidi.jar ~/Documents/Processing/librairies/rwmidi/library/_

### MIDI Driver Setup

1. Open **MIDI Driver Setup** in _/Applications/Audio MIDI Setup.app_
1. In the Window menu, _Show Midi Window_
1. Double Click on _IAC Driver_
1. In IAC Driver window, check the _device is online_ checkbox.

## Test installation

### GarageBand

1. Open **GarageBand** and _Open Preferences_.
1. In Preferences panel, 1 MIDI input should be detected.

### Standalone Ledpong

1. Open **Processing**, and launch sketch in _./software/processing/standalone/standalone.pde_
1. You should have a balck-&-white pixelated view of your webam
1. Modifying the **sens** value in the sketch, you can modify the threshold of the line (_sens_ value: sum of the white value in one column)

## Usage

### Arduino Firmware

Open **Arduino**, and load the firmware from _./hardware/arduino/firmware/firmware.pde_

### Processing

Open **Processing**, and launch sketch from _./software/processing/serial/serial.pde_