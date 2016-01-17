float jj; float hh; float mm; 
float min; float sec;

import oscP5.*;
import netP5.*;

OscP5 oscP5;



void settings() {
   //fullScreen(P2D, 1);
  size(400,200, P2D);
}


void setup() {
  oscP5 = new OscP5(this,8888);
}
 
 
void loop(){
background(0);
textSize (32);
textAlign(CENTER);
text(jj, width/2, height/2.5);  
} 



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/temps")==true) {
  if(theOscMessage.checkTypetag("fffff")) {
  jj = int(theOscMessage.get(0).floatValue());  // get the first osc argument
  hh = int(theOscMessage.get(0).floatValue());  // get the first osc argument
  mm = int(theOscMessage.get(0).floatValue());  // get the first osc argument
  min = int(theOscMessage.get(0).floatValue());  // get the first osc argument
  sec = int(theOscMessage.get(0).floatValue());  // get the first osc argument

  
    }
  }
}