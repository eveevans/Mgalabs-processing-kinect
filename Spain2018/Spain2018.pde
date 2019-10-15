import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;

SyphonServer server;
OscP5 oscP5;

PVector p1 = new PVector(0.5,0.26,1);
PVector p2 = new PVector(0.5,0.26,1);
PVector p3 = new PVector(0.5,0.26,1);
PVector p4 = new PVector(0.5,0.26,1);
PVector p5 = new PVector(0.5,0.26,1);
PVector p6 = new PVector(0.5,0.26,1);
PVector p7 = new PVector(0.5,0.26,1);
PVector p8 = new PVector(0.5,0.26,1);
PVector p9 = new PVector(0.5,0.26,1);
PVector p10 = new PVector(0.5,0.26,1);
PVector[] group;

Icosahedron ico1;
Icosahedron ico2;
Icosahedron ico3;

Integer lastPVectorIndex = 0;

color [] colors = { 
  color(20,255,62, 200), 
  color(204,0,21, 200),
  color(20,255,255, 200), 
  color(255, 150, 30, 200), 
  color(240, 20, 255,200), 
  color(1226, 244,0, 200), 
  color(153, 255, 230, 200),
  color(99, 0, 173, 200), 
  color(255, 70, 70, 200), 
  color(163, 255, 255,200) 
};

void setup() {
  frameRate(25);
  size(1920,1080, P3D);
  strokeWeight(4);
  server = new SyphonServer(this, "SpainSyphon");
  oscP5 = new OscP5(this, 7001);
  group = new PVector[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 };
  ico1 = new Icosahedron(25);
  ico2 = new Icosahedron(75);
  ico3 = new Icosahedron(75);
}

void draw() {
  background(0,0,0,0);
  lights();
  stroke(255);
  noFill();
  
  strokeWeight(8);
  ellipse(width/2, height/4, 100, 100);
  ellipse(width/2, 864, 100, 100);
  
  strokeWeight(2);
  line(960,280,0.5,  960,864, 0.9);
  
  for(int i=0; i<group.length; i++) {
    float vx = group[i].x * width;
    float vy = group[i].y * height;
    float vz = group[i].z;
    float zRadius = 100/vz;
    
    if(group[i].x != 0.5 && group[i].y != 0.2 &&  group[i].z != 1) {
      stroke(colors[i]);
      strokeWeight(4);
      color ellipseColor = color(  red(colors[i]), green(colors[i]), blue(colors[i]), alpha(colors[i]) - 50);
      fill(ellipseColor); 
      ellipse( vx , vy , zRadius, zRadius);
      //pushMatrix();
       // translate(vx, vy, zRadius);
        //rotateX(frameCount*PI/185);
        //rotateY(frameCount*PI/-200);
        //ellipse( 0 , 0, zRadius, zRadius);
        //ico1.create(1);
        //sphere(zRadius);
      //popMatrix();
      stroke(255);
      strokeWeight(2);
      line(960,280,0.5, vx, vy, vz);
      line(960,864,0.9, vx, vy, vz);
      
      textSize(16);
      fill(255,255,255);
      text("x: " + group[i].x , vx+zRadius, vy-20);
      text("y: " + group[i].y , vx+zRadius, vy+0);
      text("z: " + group[i].z , vx+zRadius, vy+20);
    }

    if(i>0){
      if(group[i].x != 0.5 && group[i].y != 0.26 &&  group[i].z != 1) {
        line(vx, vy, vz, group[i-1].x * width, group[i-1].y * height, group[i-1].z);
        lastPVectorIndex = i;
      }
    }
    
  }
  
  // connect first user with last 'alive' user to close the shape
  line(group[0].x * width, group[0].y * height, group[0].z, group[lastPVectorIndex].x * width,  group[lastPVectorIndex].y * height,  group[lastPVectorIndex].z); 

  
    // restart original position (to hide when not active)
  for(int i=0; i<group.length; i++){
    if(frameCount % 100 == 0)
      group[i].set(0.5,0.26,1);
  }
  
  server.sendScreen();
}

void oscEvent(OscMessage message){
  if(message.checkAddrPattern("Torso_1")==true) p1.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_2")==true) p2.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_3")==true) p3.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_4")==true) p4.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_5")==true) p5.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_6")==true) p6.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_7")==true) p7.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_8")==true) p8.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_9")==true) p9.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_10")==true) p10.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
}