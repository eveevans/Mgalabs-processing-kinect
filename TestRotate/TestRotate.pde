
PImage right_arm;

  
PVector v1 = new PVector(320, 240, 0);
PVector v2 = new PVector(420, 340, 0);

void setup() {
  size(640, 480, P3D);  
  background(0);
  right_arm = loadImage("data/right_arm.png");
  
  //noStroke();
}

void draw() {
  background(0);
  
  ellipse(320, 240, 5, 5);
  ellipse(420, 340, 5, 5);
  
  
  //rotate(PI/3.0);
  
  
  
 // lo que quieres es la rotación del segmento [codo, mano], por tanto
 // la resta de v2 de v1 dará el segmento basado en el origen
  PVector v3 = PVector.sub(v2, v1);
 
 // tan de teta = Sin / Cos = Y / X
  float a = atan2(v3.y, v3.x);
  // en el ejemplo da -90 puesto que el eje Y va para abajo y v2 esta arriba de v1
  // ya depende de como trabajes con el eje Y.
  

  
  println("a: ");
  println(degrees(a));  // Prints "10.304827"
  println(a);
  
  
  translate(320, 240);
  rotate( a );
  image(right_arm,0,0);
  
}

