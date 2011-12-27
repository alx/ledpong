var firmata = require('firmata');

var usb = "/dev/tty.usbmodemfa131";
var address = [0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F];

console.log("usb");

var board = new firmata.Board(usb,function(){
  console.log("inside board");
  board.sendI2CConfig();

  board.on('string',function(string){
		console.log(string);
	});

  // Config
  for (var i = 0; i < address.length; i++) {
    console.log("address: " + address[i]);
    // blink 0 aan, 0x10 is glob uit
    board.sendI2CWriteRequest(address[i], [0xF, 0x10]);

    // input en output config.
    board.sendI2CWriteRequest(address[i], [0x6, 0x00]);

    // oninterresante getallen, afblijven!!
    board.sendI2CWriteRequest(address[i], [0x7, 0x00]);

    // global intensity reg.
    board.sendI2CWriteRequest(address[i], [0x2, 0xFF]);

    // Register 3
    board.sendI2CWriteRequest(address[i], [0x3, 0xFF]);

    // config bit
    board.sendI2CWriteRequest(address[i], [0xe, 0xFF]);
  }

  console.log("end config");

  // Led ON
  for (var i = 0; i < address.length; i++) {
    console.log("led: " + address[i]);
    for (var j = 0; j < 8; j++) {
      board.sendI2CWriteRequest(address[i], [0x10, 0xFF]);
    };
  }

  console.log("end led");
});
