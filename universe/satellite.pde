class Satellite {

  private PShape moonShape;
  private PImage moonTexture;
  private float rotationAngle, rotationSpeed, radius;
  private float x, y, z;

  Satellite(float x, float y, float z, float radius) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.rotationAngle = 0;
    this.rotationSpeed = 0.5 * random(1, 3);
    this.moonShape = createShape(SPHERE, this.radius);
    this.moonTexture = loadImage(moonPath);
    this.moonShape.setTexture(moonTexture);
    this.moonShape.setStroke(0);
  }

  void display() {
    rotateY(radians(rotationAngle));
    translate(x, y, z);
    shape(moonShape);
  }

  void update() {
    rotationAngle += rotationSpeed;
    if (rotationAngle >= 360) rotationAngle -= 360;
  }
}
