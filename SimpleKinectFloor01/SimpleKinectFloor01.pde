import oscP5.*;

void setup() {
  size(800,600);
  ni_mate_setup();
  smooth();
  background(0);
}

void draw() {
  background(0);
  textSize(16);
  
  translate(width/2, 0);                    // Movido al centro de la patalla para mas facil uso de valor de x_factor 
  
  float max_x_range = 1.4;                  // Valor maximo en rango x obtenido de Kinect
  float x_factor = (width/2)/max_x_range;   // width/2 por que se esta ocupando el centro de la pantalla  como (0,0)
  
  float max_y_range = 4.0;                  // Valor maximo obtenido de z (por que se esta ocupando el eje del piso) 
  float y_factor = height/max_y_range;
  
  for(int i=0; i<group.length; i++){
    translate(-1 * width/2, 0); // para no afectar el texto con el translate
    text("p" + i + ".x: " + group[i].x , 150*i, 50);
    text("p" + i + ".y: " + group[i].y , 150*i, 100);
    text("p" + i + ".z: " + group[i].z , 150*i, 150);
    translate(width/2, 0);
    //fill(255,255,255,100);
    fill(colors[i]);    
    //noFill();
    noStroke();
    ellipse(group[i].x * x_factor, group[i].z * y_factor, group[i].y*20, group[i].y*20);
    
    stroke(255,255,255,50);
    if(i>0){
      line(group[i].x * x_factor, group[i].z * y_factor, group[i-1].x * x_factor, group[i-1].z * y_factor);
    }
  }
 
  
  ellipse(200,300, 10, 10);
  
}

PVector p1 = new PVector(0,0,0);
PVector p2 = new PVector(0,0,0);
PVector p3 = new PVector(0,0,0);
PVector p4 = new PVector(0,0,0);
PVector p5 = new PVector(0,0,0);
PVector[] group;


color [] colors = { color(100,255,35, 100), color(220,200,85, 100),
color(185,65,200, 100), color(0,145,35, 100), color(245,35,200,100) };

void ni_mate_setup(){
  new OscP5(this, 7000);
  group = new PVector[] { p1, p2, p3, p4, p5 };
}

void oscEvent(OscMessage message){
  if(message.checkAddrPattern("Torso_1")==true) p1.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_2")==true) p2.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_3")==true) p3.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_4")==true) p4.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
  if(message.checkAddrPattern("Torso_5")==true) p5.set(message.get(0).floatValue(),message.get(1).floatValue(), message.get(2).floatValue());
}



