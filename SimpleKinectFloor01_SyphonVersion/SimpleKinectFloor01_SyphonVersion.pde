import oscP5.*;
import netP5.*;

OscP5 oscP5;

import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

void setup() {
  frameRate(90);
  size(1024,1536, P3D);
  oscP5 = new OscP5(this, 7001);
  
  ni_mate_setup();
  smooth();
  background(0,0,0,0);
  
  canvas = createGraphics(1024,1536, P3D);
  server = new SyphonServer(this, "Piso");
}

void draw() {
  canvas.beginDraw();
  canvas.background(0,0,0,0);
  canvas.textSize(16);
  
  canvas.translate(width/2, 0);                    // Movido al centro de la patalla para mas facil uso de valor de x_factor 
  
  float max_x_range = 1.4;                  // Valor maximo en rango x obtenido de Kinect
  float x_factor = (546/2)/max_x_range;   // width/2 por que se esta ocupando el centro de la pantalla  como (0,0)
  
  float max_y_range = 4.0;                  // Valor maximo obtenido de z (por que se esta ocupando el eje del piso) 
  float y_factor = 546/max_y_range;
  
  
  for(int i=0; i<group.length; i++){
    canvas.translate(-1 * width/2, 0); // para no afectar el texto con el translate
    canvas.text("p" + i + ".x: " + group[i].x , 150*i, 50);
    canvas.text("p" + i + ".y: " + group[i].y , 150*i, 100);
    canvas.text("p" + i + ".z: " + group[i].z , 150*i, 150);
    canvas.translate(width/2, 0);
    //fill(255,255,255,100);
    canvas.fill(colors[i]);
    //noFill();
    //canvas.noStroke();
    
    float vx = group[i].x * x_factor;
    float vy = group[i].z * y_factor;
    float vv = group[i].y;
    //canvas.ellipse(vx, vy, group[i].y*20, group[i].y*20);
    
    canvas.stroke(colors[i]);
    //canvas.noFill();
    canvas.beginShape();
    for(int l=1;l<=10;l++){
      canvas.vertex(vx+random(100*vv)-50, vy+random(100*vv)-50);
    }
    canvas.endShape(CLOSE);

    
    canvas.stroke(255,255,255,200);
    if(i>0){
      if(group[i].x !=0 && group[i].z != 0)
      canvas.line(group[i].x * x_factor, group[i].z * y_factor, group[i-1].x * x_factor, group[i-1].z * y_factor);
    }
  }
 
  
  canvas.ellipse(200,300, 10, 10);
  
  canvas.endDraw();
  image(canvas,0,0); // Ojo con esto, por la parte de las coordenadas
  server.sendImage(canvas);
  
}

PVector p1 = new PVector(0,0,0);
PVector p2 = new PVector(0,0,0);
PVector p3 = new PVector(0,0,0);
PVector p4 = new PVector(0,0,0);
PVector p5 = new PVector(0,0,0);
PVector[] group;


color [] colors = { color(100,255,35, 200), color(220,200,85, 200),
color(185,65,200, 200), color(0,145,35, 200), color(245,35,200,200) };

void ni_mate_setup(){
  new OscP5(this, 7001);
  group = new PVector[] { p1, p2, p3, p4, p5 };
}

void oscEvent(OscMessage message){
  if(message.checkAddrPattern("Torso_1")==true) p1.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_2")==true) p2.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_3")==true) p3.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_4")==true) p4.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_5")==true) p5.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
}



