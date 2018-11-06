import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;

SyphonServer server;
OscP5 oscP5;

PVector p1 = new PVector(0.5,0.5,1);
PVector p2 = new PVector(0.5,0.5,1);
PVector p3 = new PVector(0.5,0.5,1);
PVector p4 = new PVector(0.5,0.5,1);
PVector p5 = new PVector(0.5,0.5,1);
PVector p6 = new PVector(0.5,0.5,1);
PVector p7 = new PVector(0.5,0.5,1);
PVector p8 = new PVector(0.5,0.5,1);
PVector p9 = new PVector(0.5,0.5,1);
PVector p10 = new PVector(0.5,0.5,1);
PVector[] group;

color [] colors = { 
  color(100,255,35, 200), 
  color(220,200,85, 200),
  color(185,65,200, 200), 
  color(0,145,35, 200), 
  color(245,35,200,200), 
  color(100,255,35, 200), 
  color(220,200,85, 200),
  color(185,65,200, 200), 
  color(0,145,35, 200), 
  color(245,35,200,200) 
};

void setup() {
  size(1920,1080, P3D);
  strokeWeight(4);
  server = new SyphonServer(this, "SpainSyphon");
  oscP5 = new OscP5(this, 7001);
  group = new PVector[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 };
}

void draw() {
  background(0,0,0,0);
 
  noFill();
  stroke(255);
  
  for(int i=0; i<group.length; i++){
    //fill(colors[i]);
      
    
    float vx = group[i].x * width;
    float vy = group[i].y * height;
    float vz = group[i].y; 
    
    point(group[i].x * width, group[i].y * height, vz);
    ellipse( vx , vy , 100/group[i].z, 100/group[i].z);
    
    line(960,540,0.5, vx, vy, vz);
    
    text("p" + i + ".x: " + group[i].x , vx+20, vy-20);
    text("p" + i + ".y: " + group[i].y , vx+20, vy+0);
    text("p" + i + ".z: " + group[i].z , vx+20, vy+20);
    
    //stroke(colors[i]);
    //beginShape();
    //for(int l=1;l<=10;l++){
     // vertex(vx+random(100), vy+random(100));
    //}
    //endShape(CLOSE);
    
    if(i>0){
      if(group[i].x !=0 && group[i].z != 0) {
        line(vx, vy, vz, group[i-1].x * width, group[i-1].y * height, group[i-1].z);
      }
    }
    
  }
  
  //print(vectors[0]);

  server.sendScreen();
}

void oscEvent(OscMessage message){
  if(message.checkAddrPattern("Head_1")==true) p1.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_2")==true) p2.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_3")==true) p3.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_4")==true) p4.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_5")==true) p5.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_6")==true) p6.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_7")==true) p7.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_8")==true) p8.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_9")==true) p9.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Head_10")==true) p10.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
}