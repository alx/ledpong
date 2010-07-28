# LedPong

## Installation

### RWMidi

1. Open terminal and create a folder for Processing to rwmidi library: 'mkdir -p ~/Documents/Processing/librairies/rwmidi/library/'
1. Copy the RWMidi lib to in Processing folder: 'cp ./lib/rwmidi/rwmidi.jar ~/Documents/Processing/librairies/rwmidi/library/'

### MIDI Driver Setup

1. Open MIDI Driver Setup in '/Applications/Audio MIDI Setup.app'
1. In the Window menu, 'Show Midi Window'
1. Double Click on 'IAC Driver'
1. In IAC Driver window, check the 'device is online' checkbox.

## Test installation

### GarageBand

1. Open GarageBand and Open Preferences.
1. In Preferences, 1 MIDI input should be detected.

### Standalone Ledpong

1. Open Processing, and launch sketch in './processing/standalone/standalone.pde'
1. You should have a balck-&-white pixelated view of your webam
1. Modifying the 'sens' value in the sketch, you can modify the threshold of the line (send: sum of the white value in one column)

## Usage

### Arduino Firmware

Open Arduino.app, and load the firmware from './arduino/firmware/firmware.pde'

### Processing

Open Processing, and launch sketch from './processing/serial/serial.pde'