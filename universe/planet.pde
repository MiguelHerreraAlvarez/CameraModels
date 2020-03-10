class Planet {

  private PShape planetShape;
  private PImage planetTexture;
  private float rotationAngle, rotationSpeed, radius;
  private float x, y, z;
  private Satellite moon;
  private boolean hasMoon;
  private String name;

  Planet(float x, float y, float z, float radius, String planetPath, boolean hasMoon, String name) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.rotationAngle = 0;
    this.rotationSpeed = 0.55 * random(1, 2);
    this.hasMoon = hasMoon;
    this.planetShape = createShape(SPHERE, this.radius);
    this.planetTexture = loadImage(planetPath);
    this.planetShape.setTexture(planetTexture);
    this.planetShape.setStroke(0);
    this.name = name;

    if (hasMoon) {
      float moonRadio = radius / random(6, 8);
      this.moon = new Satellite(x * 0.1, y * 0.075, 0, moonRadio);
    }
  }

  void display() {
    rotateY(radians(rotationAngle));
    translate(x, y, z);
    textAlign(CENTER);
    text(name, 0, -(radius + 10));
    shape(planetShape);
    if (hasMoon) drawMoon();
  }

  void update() {
    rotationAngle += rotationSpeed;
    if (rotationAngle >= 360) rotationAngle -= 360;
  }

  void drawMoon() {
    pushMatrix();
    moon.display();
    popMatrix();
    moon.update();
  }
}
