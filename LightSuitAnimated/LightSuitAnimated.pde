import oscP5.*;

int numFrames = 3;
int currentFrame = 0;
PImage[] suits = new PImage[numFrames];
PImage right_arm;
PImage left_arm;
PImage right_leg;
PImage left_leg;
PImage head;

// new
PVector vtemp = new PVector(0,0,0);
float angle;

void setup() {
  size(640, 480);
  //frameRate(1);
  
  NI_mate_map_setup_function();
  smooth();
  background(0);
  
  suits[0] = loadImage("data/suit_01.png");
  suits[1] = loadImage("data/suit_02.png");
  suits[2] = loadImage("data/suit_03.png");
  head = loadImage("data/head.png");
  right_arm = loadImage("data/right_arm.png");
  left_arm = loadImage("data/right_arm.png");
  right_leg = loadImage("data/right_arm.png");
  left_leg = loadImage("data/right_arm.png");
  
  //noStroke();
}

void draw() {
  background(0);
  
  for(int i=0;i<skeleton.length; i++){
    ellipse(skeleton[i].x, skeleton[i].y, 5, 5);      
  }
  
  //currentFrame = (currentFrame+1) % numFrames;
  //image(suits[currentFrame], sk_torso.x-320, sk_torso.y-240);
  
  //textSize(32);
  text("Mano derecha: " + sk_right_hand.y, 10, 10); 

   
   draw_rotated_image(right_arm, sk_right_elbow, sk_right_hand);
   draw_rotated_image(left_arm, sk_left_elbow, sk_left_hand);
   draw_rotated_image(right_leg, sk_right_knee, sk_right_foot);
   draw_rotated_image(left_leg, sk_left_knee, sk_left_foot);
   draw_rotated_image(head, sk_head, sk_neck);
   
     
  if( (sk_right_hand.y > 0 && sk_right_hand.y <= 160) || ( sk_left_hand.y > 0 && sk_left_hand.y <= 160 )  ){
     image(suits[2], sk_torso.x-320, sk_torso.y-240);
   }
   else if( (sk_right_hand.y > 160 && sk_right_hand.y <= 220) || (sk_left_hand.y > 160 && sk_left_hand.y <= 220) ){
     image(suits[1], sk_torso.x-320, sk_torso.y-240);
   }
   else {
     draw_rotated_body( suits[0], sk_left_shoulder, sk_right_shoulder, sk_torso);
     //image(suits[0], sk_torso.x-320, sk_torso.y-240);
   }
  
}

void draw_rotated_image(PImage image_to_draw, PVector a, PVector b){
  vtemp = PVector.sub(b,a);
  angle = atan2(vtemp.y, vtemp.x);
  translate(a.x, a.y);
  rotate(angle);
  image(image_to_draw, 0, 0);
  rotate(-angle);
  translate(-a.x,-a.y);
}

void draw_rotated_body(PImage image_to_draw, PVector a, PVector b, PVector center){
  vtemp = PVector.sub(b,a);
  angle = atan2(vtemp.y, vtemp.x);
  translate(center.x, center.y);
  rotate(angle);
  image(image_to_draw, -image_to_draw.width/2,-image_to_draw.height/2);
  //rotate(-angle);
  //translate(-a.x+image_to_draw.width/2, -a.y+image_to_draw.height/2);
  
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
