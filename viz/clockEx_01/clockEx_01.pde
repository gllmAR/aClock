int cx, cy;
int radius;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;
int monTemps;
String journee = "Nada";String textMe = "Nada2";
int mil;
float opacity = 1.;
float trail = 0.;

float s = 0;
float m = 0;
float h = 0;


import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void settings() {
   fullScreen();
  //size(400,400);
}

void setup() {
  oscP5 = new OscP5(this,7776);
  myRemoteLocation = new NetAddress("127.0.0.1",7778);
  

  
  radius = min(width, height) / 2;
  secondsRadius = radius * 0.9;
  minutesRadius = radius * 0.80;
  hoursRadius = radius * 0.70;
  clockDiameter = radius * 1.8;
  
  cx = width / 2;
  cy = height / 2;
  
  monTemps = 7*24*60*60;

  background(0);
   
    
  OscMessage myMessage = new OscMessage("/processing");
  myMessage.add("ready"); /* add an int to the osc message */
  oscP5.send(myMessage, myRemoteLocation); 
  

}

void update(){
  int t = monTemps;
  float monJour = t/60./60./24. ;
  float monHeure = (monJour-int(monJour))*24. ;
  float maMinute = (monHeure-int(monHeure))*60.;
  float maSeconde = (maMinute -int(maMinute))*60.;

    
switch(int(monJour)) {
  case 0: 
     journee = "Dimanche";
    break;
  case 1: 
     journee = "Samedi";
    break;
  case 2: 
     journee = "Vendredi";
    break;
  case 3: 
    journee = "Jeudi";
    break; 
  case 4: 
     journee = "Mercredi"; 
     break;
 case 5: 
     journee = "Mardi";
    break;  
  case 6: 
    journee = "Lundi";
    break;  
  case 7: 
     journee = "Dimanche";
    break;    
}
  
textMe = nf(int(monHeure),2)+":"+nf(int(maMinute),2)+":"+nf(int(maSeconde),2);

s = map(maSeconde, 0, 60, 0, TWO_PI) - HALF_PI;
m = map(maMinute, 0, 60, 0, TWO_PI) - HALF_PI; 
h = map(monHeure%12, 0, 24, 0, TWO_PI * 2) - HALF_PI;



}

void draw() {
  
  update();
 
  noStroke();
  fill(0, (1-trail)*255);
  rect(0, 0, width, height);

  
   // Draw the clock background

  textSize(radius/10);
  
  fill(255,255,255, (opacity*255));
  textAlign(CENTER);
  text(journee, width/2, height/2.5);  
  text(textMe, width/2, height/1.5); 
  
  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top 
  
  // Draw the hands of the clock
  stroke(255, (opacity*255));

// secondes 
//  strokeWeight(1);
//  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  
  strokeWeight(radius/80);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(radius/50);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
   
  // Draw the minute ticks
  strokeWeight(radius/30);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();

}




/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/temps")==true) {
  if(theOscMessage.checkTypetag("f")) {
  monTemps = int(theOscMessage.get(0).floatValue());  // get the first osc argument
    }
  }
  if(theOscMessage.checkAddrPattern("/opacity")==true) {
  if(theOscMessage.checkTypetag("f")) {
  opacity = theOscMessage.get(0).floatValue();  // get the first osc argument
    }
  }
  
    if(theOscMessage.checkAddrPattern("/trail")==true) {
  if(theOscMessage.checkTypetag("f")) {
  trail = theOscMessage.get(0).floatValue();  // get the first osc argument
    }
  }



}