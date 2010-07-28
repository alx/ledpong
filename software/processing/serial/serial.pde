// Video2ledwallHarpSerial
// v1.0 by Fabrice Fourc
// may 2010
// http://www.tetalab.org
import processing.video.*;
import processing.net.*;

import rwmidi.*;

MidiOutput output;

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 10;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object

import processing.serial.*;

// The serial port:
Serial myPort;



// Send a capital A out the serial port
//myPort.write(65);

//luminosite globale de la colone pour le son
int colValue;
int sens=1000;
int beatsPerSecond = 8;
int fps = 0;


String ledCol;
String ledWallMsg;

//Client myClient;
Capture video;

int scale[] = new int[] { 0, 2, 3, 5, 7, 8, 10, 12 };
static final int NUM_VALUES = 8;
int pitchValue(int x) {
  return scale[cellValue(x)] + x % 3 * 12 + 40;
}
int cellValue(int x) {
  return (x) % NUM_VALUES;
}



void setup() {
  size(270,160);
  frameRate(25);
//liste des devices midi
 MidiOutputDevice devices[] = RWMidi.getOutputDevices();
  for (int i = 0; i < devices.length; i++) {
    println(i + ": " + devices[i].getName());
  }
  output = RWMidi.getOutputDevices()[0].createOutput();
  

  
  
  // List all the available serial ports:
println(Serial.list());

// I know that the first port in the serial list on my mac
// is always my  Keyspan adaptor, so I open Serial.list()[0].
// Open whatever port is the one you're using.
myPort = new Serial(this, Serial.list()[0], 38400);
   //myClient = new Client(this, "127.0.0.1", 5204);
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
  video = new Capture(this,cols,rows,30);
}

void draw() {
  fps++;
  // Read image from the camera
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  
  
  ledWallMsg ="";
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    ledCol = "";
    colValue=0;
    for (int j = 0; j < rows; j++) {
      
      // Where are we, pixel-wise?
      int x = i*videoScale;
      int y = j*videoScale;
      // Looking up the appropriate color in the pixel array
      color c = video.pixels[i + j*video.width];
      //println("---------");
      //println(video.width);
      
      int value = (int)brightness(c);  // get the brightness
      fill(value);
      //println(hex(value/16,1));
       colValue += value;
      ledCol +=hex(value/16,1); 
      //fill(c);
      stroke(0);
      rect(x,y,videoScale,videoScale);
    }
   //ledWallMsg += ledCol;
   //fps++;
   //somme des luminosite d'une colone pour sortir un son
   //println (colValue+":");
     if (colValue>sens){
      // println ("son sur corde : "+i);
           if (fps > (frameRate / beatsPerSecond)) {
        
             
         println ("son sur corde : "+i+ " fps : " +fps +" PITCH : "+pitchValue(i)+"FR/bpm : "+ frameRate / beatsPerSecond);
          output.sendNoteOn(0, pitchValue(i), 100);
          stroke(0);
          rect(i*videoScale+1,0,videoScale,videoScale*rows);
        fps = 0;
         //fps++;
        ledWallMsg += "FFFFFFFFFFFFFFFF";
         
            }else{
               ledWallMsg += ledCol;
            }
       }else{
         ledWallMsg += ledCol;
          

     }
  }
  
  //send pix to the Led Wall
  //println(ledWallMsg);
  myPort.write('Z'+ledWallMsg);
   //myClient.write(ledWallMsg);
   //Seri.write(ledWallMsg);
   // delay(100);
}

