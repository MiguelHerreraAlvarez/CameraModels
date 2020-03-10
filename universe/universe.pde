Star sun;
PShape ship;
PImage background;
String backgroundPath = "../images/background.jpg";
String sunPath = "../images/sun.jpg";
String mercuryPath = "../images/mercury.jpg";
String venusPath = "../images/venus.jpg";
String earthPath = "../images/earth.jpg";
String marsPath = "../images/mars.jpg";
String jupiterPath = "../images/jupiter.jpg";
String moonPath = "../images/moon.jpg";

float yaw = -180;
float pitch = 10;
PVector direction = new PVector(0,0,1);
PVector cameraPos = new PVector(width/2 ,height/2 -100,(height/2.0) / tan(PI*30.0 / 180.0));
PVector shipPos = new PVector(0,0,0);
PVector up = new PVector(0, 1, 0);
int dist = 500;
float horizontalDistance;
float verticalDistance;

boolean isSpaceShipView;
boolean wPress = false, sPress = false, aPress = false, dPress = false;
boolean upPress = false, downPress = false, leftPress = false, rightPress = false;
float step = 5.0;
float angleStep = 1;

void setup() {
  size(1366, 768, P3D);
  imageMode (CENTER) ;
  background = loadImage (backgroundPath);
  sun = new Star(width/2, height/2, 0, 100);
  ship = createShape(BOX, 20);
}

void draw() {
  background(background);
  
  if (!isSpaceShipView){
    camera();
  }else{
    updateCameraPosition();
    camera(
      cameraPos.x, cameraPos.y, cameraPos.z,
      shipPos.x, shipPos.y, shipPos.z,
      up.x, up.z, up.y);
    pushMatrix();
    translate(shipPos.x, shipPos.y, shipPos.z);
    shape(ship);
    popMatrix();
  }
  
  sun.display();
  sun.update();
}

void keyPressed(){
  if (keyCode == ENTER){
    isSpaceShipView = !isSpaceShipView;
  }else if (key == 'w'){
    wPress = true;
  }else if (key == 's'){
    sPress = true;
  }else if (key == 'a'){
    aPress = true;
  }else if (key == 'd'){
    dPress = true;
  }else if (keyCode == UP){
    upPress = true;
  }else if (keyCode == DOWN){
    downPress = true;
  }else if (keyCode == LEFT){
    leftPress = true;
  }else if (keyCode == RIGHT){
    rightPress = true;
  }
}

void keyReleased(){
  if (key == 'w'){
    wPress = false;
  }
  if (key == 's'){
    sPress = false;
  }
  if (key == 'a'){
    aPress = false;
  }
  if (key == 'd'){
    dPress = false;
  }
  if (keyCode == UP){
    upPress = false;
  }
  if (keyCode == DOWN){
    downPress = false;
  }
  if (keyCode == LEFT){
    leftPress = false;
  }
  if (keyCode == RIGHT){
    rightPress = false;
  }
}

void updateShipVectors(){
  horizontalDistance = dist * cos(radians(pitch));
  verticalDistance = dist * sin(radians(pitch));
  cameraPos.y = shipPos.y + verticalDistance;
  cameraPos.x = shipPos.x + horizontalDistance * sin(radians(yaw));
  cameraPos.z = shipPos.z + horizontalDistance * cos(radians(yaw));
  direction.x = sin(radians(yaw)) * cos(radians(pitch));
  direction.z = cos(radians(yaw)) * cos(radians(pitch));
  direction.y = sin(radians(pitch));
  direction.normalize();
}

void updateCameraPosition(){
  if (wPress){
    shipPos.add(PVector.mult(direction, 5));
  }
  
  if (sPress){
    shipPos.sub(PVector.mult(direction, 5));
  }
  
  if (aPress){
    PVector producto = new PVector();
    PVector.cross(direction, up, producto);
    producto.normalize();
    shipPos.sub(PVector.mult(producto, 5));
  }
  
  if (dPress){
    PVector producto = new PVector();
    PVector.cross(direction, up, producto);
    producto.normalize();
    shipPos.add(PVector.mult(producto, 5));
  }
  
  if (upPress){
    pitch -= 1;
    pitch = pitch % 360;
  }
  
  if (downPress){
    pitch += 1;
    pitch = pitch % 360;
  }
  
  if (leftPress){
    yaw -= 1;
    yaw = yaw % 360;
  }
  
  if (rightPress){
    yaw += 1;
    yaw = yaw % 360;
  }
  
  updateShipVectors();
}
