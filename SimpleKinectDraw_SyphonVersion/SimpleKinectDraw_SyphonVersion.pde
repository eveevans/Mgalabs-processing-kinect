import oscP5.*;
import netP5.*;

OscP5 oscP5;

import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

int head_size = 30;

void setup() {
  size(800, 600, P3D);
  oscP5 = new OscP5(this,7000);
  NI_mate_map_setup_function();
  
  smooth();
  background(0);
  //noStroke();
  
  canvas = createGraphics(800, 600, P3D);
  server = new SyphonServer(this, "otro");
}

void draw() {
  canvas.beginDraw();
  
  canvas.background(0);
  
  for(int i=0;i<skeleton.length; i++){
    canvas.ellipse(skeleton[i].x, skeleton[i].y, 5, 5);      
  }
  
  canvas.stroke(255);
  canvas.noFill();
  
  canvas.strokeWeight(8);
  
  // spine line
  canvas.line(sk_head.x, sk_head.y+head_size, (sk_left_shoulder.x + sk_right_shoulder.x)/2, (sk_left_shoulder.y + sk_right_shoulder.y)/2 ) ; 
  canvas.line(sk_torso.x, sk_torso.y, (sk_left_hip.x + sk_right_hip.x)/2 , (sk_left_hip.y + sk_right_hip.y)/2 );
  
  //torso
  canvas.fill(255,255,255,255);
  canvas.triangle(sk_left_shoulder.x,sk_left_shoulder.y, sk_right_shoulder.x, sk_right_shoulder.y, sk_torso.x, sk_torso.y);
  canvas.noFill();
  //quad(sk_left_shoulder.x,sk_left_shoulder.y, sk_left_hip.x, sk_left_hip.y, sk_right_hip.x, sk_right_hip.y, sk_right_shoulder.x, sk_right_shoulder.y);
  
  //left arm
  canvas.bezier(sk_left_shoulder.x, sk_left_shoulder.y, sk_left_elbow.x,sk_left_elbow.y,sk_left_elbow.x,sk_left_elbow.y  , sk_left_hand.x,sk_left_hand.y);
  
  //right arm
  canvas.bezier(sk_right_shoulder.x, sk_right_shoulder.y, sk_right_elbow.x,sk_right_elbow.y,sk_right_elbow.x,sk_right_elbow.y  , sk_right_hand.x,sk_right_hand.y);
  
  // left leg
  //print(sk_left_foot.x);
  canvas.bezier(sk_left_hip.x, sk_left_hip.y, sk_left_knee.x, sk_left_knee.y, sk_left_knee.x, sk_left_knee.y,  sk_left_foot.x, sk_left_foot.y);
  
  // right leg
  canvas.bezier(sk_right_hip.x, sk_right_hip.y, sk_right_knee.x, sk_right_knee.y, sk_right_knee.x, sk_right_knee.y, sk_right_foot.x, sk_right_foot.y);
  
  // Pant
  canvas.fill(255,255,255,255);
  canvas.triangle(sk_left_hip.x, sk_left_hip.y, sk_right_hip.x , sk_right_hip.y, (sk_left_hip.x + sk_right_hip.x)/2, (sk_left_hip.y + sk_right_hip.y)/2 + 30);  
  
  // head
  float zoom = map(sk_head.z, 4,0, 1,2);
  canvas.fill(255,255,255,255);
  
  canvas.translate(sk_head.x - sk_head.x * zoom , sk_head.y - sk_head.y *zoom);  
  canvas.scale(zoom);  
  canvas.strokeWeight(1.0/zoom);
  canvas.triangle(sk_head.x-head_size, sk_head.y+head_size, sk_head.x, sk_head.y-head_size, sk_head.x+head_size, sk_head.y+head_size);
  canvas.noFill();
 
  
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
  
}

PVector sk_left_audio = new PVector(0,0,0);
PVector sk_right_audio = new PVector(0,0,0);
PVector sk_left_shoulder = new PVector(0,0,0);
PVector sk_head = new PVector(0,0,0);
PVector sk_right_shoulder = new PVector(0,0,0);
PVector sk_left_elbow = new PVector(0,0,0);
PVector sk_right_elbow = new PVector(0,0,0);
PVector sk_left_hand = new PVector(0,0,0);
PVector sk_neck = new PVector(0,0,0);
PVector sk_right_hand = new PVector(0,0,0);
PVector sk_left_hip = new PVector(0,0,0);
PVector sk_right_hip = new PVector(0,0,0);
PVector sk_left_knee = new PVector(0,0,0);
PVector sk_torso = new PVector(0,0,0);
PVector sk_right_knee = new PVector(0,0,0);
PVector sk_left_foot = new PVector(0,0,0);
PVector sk_right_foot = new PVector(0,0,0);
PVector sk_omni_format = new PVector(0,0,0);
PVector[] skeleton; 

void NI_mate_map_setup_function() {
  new OscP5(this, 7000);
  skeleton = new PVector[]{sk_left_audio, sk_right_audio, sk_left_shoulder, sk_head, sk_right_shoulder, sk_left_elbow, sk_right_elbow, sk_left_hand, sk_neck, sk_right_hand, sk_left_hip, sk_right_hip, sk_left_knee, sk_torso, sk_right_knee, sk_left_foot, sk_right_foot, sk_omni_format};
}

void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/Audio_input_left")==true) sk_left_audio.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Audio_input_right")==true) sk_right_audio.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Shoulder")==true) sk_left_shoulder.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Head")==true) sk_head.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Shoulder")==true) sk_right_shoulder.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Elbow")==true) sk_left_elbow.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Elbow")==true) sk_right_elbow.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Hand")==true) sk_left_hand.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Neck")==true) sk_neck.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Hand")==true) sk_right_hand.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Hip")==true) sk_left_hip.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Hip")==true) sk_right_hip.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Knee")==true) sk_left_knee.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Torso")==true) sk_torso.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Knee")==true) sk_right_knee.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Left_Foot")==true) sk_left_foot.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/Right_Foot")==true) sk_right_foot.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
  if(message.checkAddrPattern("/skeleton")==true) sk_omni_format.set(message.get(0).floatValue()*width, message.get(1).floatValue()*height, message.get(2).floatValue());
}
