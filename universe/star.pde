class Star {
  
  private PShape sunShape;
  private PImage sunTexture; 
  private float rotationAngle, rotationSpeed, radius;
  private float x, y, z;
  private ArrayList<Planet> planets;

  Star(float x, float y, float z, float radius) {
    this.planets = new ArrayList<Planet>();
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.rotationAngle = 0;
    this.rotationSpeed = 0.25;
    this.sunTexture = loadImage(sunPath);
    this.sunShape = createShape(SPHERE, this.radius); 
    this.sunShape.setTexture(sunTexture);
    this.sunShape.setStroke(0);
    addPlanets();
  }

  void display() {
    translate(x, y, z);
    rotateX(radians(-45));
    drawSun();
    drawPlanets();
  }

  void update() {
    rotationAngle += rotationSpeed;
    if (rotationAngle >= 360) { 
      rotationAngle = 0;
    }
  }

  void addPlanets() {
    planets.add(new Planet(radius + 7 + 5, y - radius*4, 0, 7, mercuryPath, false, "Mercury"));
    planets.add(new Planet(radius + 15 + 108, y - radius*4, 0, 15, venusPath, false, "Venus"));
    planets.add(new Planet(radius + 15 + 149, y - radius*4, 0, 15, earthPath, true, "Earth"));
    planets.add(new Planet(radius + 10 + 228, y - radius*4, 0, 10, marsPath, true, "Mars"));
    planets.add(new Planet(radius + 40 + 780, y - radius*4, 0, 40, jupiterPath, true, "Jupiter"));
  }

  void drawSun() {
    pushMatrix();
    rotateY(radians(rotationAngle));
    shape(sunShape);
    popMatrix();
  }

  void drawPlanets() {
    for (Planet planet : planets) {
      pushMatrix();
      planet.display();
      popMatrix();
      planet.update();
    }
  }
}
