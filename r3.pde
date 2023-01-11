
final float SCALE = 400;

Vector3D i = new Vector3D(SCALE, 0, 0), j = new Vector3D(0, SCALE, 0), k = new Vector3D(0, 0, SCALE);

void rotateX(float angle) {
  i.rotateX(angle);
  j.rotateX(angle);
  k.rotateX(angle);
}

void rotateY(float angle) {
  i.rotateY(angle);
  j.rotateY(angle);
  k.rotateY(angle);
}

void rotateZ(float angle) {
  i.rotateZ(angle);
  j.rotateZ(angle);
  k.rotateZ(angle);
}

color white = color (255), red = color(255, 0, 0), green = color(0, 255, 0), blue = color(0, 0, 255), pink = color(255, 192, 203),
  yellow = color(255, 255, 0), cyan = color(0, 255, 255), orange = color(255, 165, 0), magenta = color (255, 0, 255), black = color (0);

float turn = (float)(Math.PI/2);

void setup_r3() {
  //rotateZ(0.5 * turn);
  //rotateX(-0.5 * turn);
  //rotateZ(-1.5 * turn);
  //rotateX(-0.5 * turn);
  //println(i);
  //println(j);
  //println(k);
}

void plotLine() {
  for (float t = 0; t >= -200; t -= 1)
    point(t, t, t, white);
}

void plotPlane() {
  pointSize = 5;
  boolean change = true;
  for (float u = -200; u <= 200; u+=2.5)
    for (float v = -200; v <= 200; v+=2.5) {
      if (change)
        point (u, v, 0, yellow);
      else
        point (u, v, 0, pink);
      if (u % 25 == 0)
        change = !change;
    }
}

void plotToroid() {
  for (float x = -100; x <= 100; x+=0.01)
    point(25 * x, 25 * x*x, 25 * x * x *x, pink);
}

void xSquared() {
  for (float x = -200; x <= 200; x+=0.1)
    point(10 * x, 10 * x*x, 0, pink);
}

void someKindOfSpiral() {
  for (float t = 0; t <= 16*Math.PI; t += 0.001)
    point(200 * cos(t), 200 * sin(t), 200/(float)(Math.pow(2.712, t)), pink);
}

void sinX() {
  for (float x = -200; x <= 200; x+=0.01)
    point(100 * x, 100 * sin(x), 0, white);
}

float param = 0;
void planetaryMotion() {
  circleOutline();
  pointSize = 55;
  point (0, 0, 0, orange);
  pointSize = 25;
  point (scale * cos(param), scale*sin(param+=0.025), 0, white);
  point (scale * cos(param - 0.5), scale*sin(param - 0.5), 0, red);
  point (scale * cos(param - 2*0.5), scale*sin(param - 2*0.5), 0, blue);
  point (scale * cos(param - 3*0.5), scale*sin(param - 3*0.5), 0, yellow);
  point (scale * cos(param - 4*0.5), scale*sin(param - 4*0.5), 0, green);
  point (scale * cos(param - 5*0.5), scale*sin(param - 5*0.5), 0, pink);
}

ArrayList<Point> circularPlate_Points;

void setupCircularPlate() {
  circularPlate_Points = new ArrayList<Point>();
  pointSize = 25;
  for (float theta = 0; theta < 2 * Math.PI; theta += 0.01)
    for (float r = 0; r < scale; r+=pointSize-0.5) {
      float x = r * cos (theta), y = r * sin(theta);
      for (float z = -100; z <= 100; z+=10)
        circularPlate_Points.add(new Point(x, y, z));
    }
}

void circularPlate() {
  for (Point p : circularPlate_Points) {
    pointSize = 12.5;
    point (p.x, p.y, p.z, color (orange, 127));
    if (abs(p.z) > 99)
      point (p.x, p.y, p.z, white);
  }
}

void circleOutline() {
  pointSize = 5;
  for (float theta = 0; theta < 2 * Math.PI; theta += 0.01)
    point (scale * cos(theta), scale * sin(theta), 0, white);
}

void pokemonBall() {
  pointSize = 2;
  float z = 0;
  for (float x = -200; x <= 200; x++)
    for (float y = -200; y <= 200; y++) {
      z = (float)(Math.sqrt(100*100-x*x-y*y));
      point (x, y, z, red);
      point (x, y, -z, white);
    }
}

void cube() {
  pointSize = 5;
  //DOWN
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (u, v, -200, yellow);
  //BACK
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (u, -200, v, green);
  //LEFT
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (-200, u, v, red);
  //RIGHT
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (200, u, v, orange);
  //UP
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (u, v, 200, white);
  //FRONT
  for (float u = -200; u <= 200; u+=4)
    for (float v = -200; v <= 200; v+=4)
      point (u, 200, v, blue);
}

boolean showStandard_r3 = false, plotFunction = false;

float currT = 0, tInc = 0.001;

void circularMotion() {
  pointSize = 2;
  float r = 400;
  for (float t = 0; t <= 2 * Math.PI; t+=0.01)
    point(r*cos(t), r*sin(t), 0, white);

  pointSize = 25;
  Vector3D X = new Vector3D(r*cos(currT), r*sin(currT), 0);
  point(r*cos(currT), r*sin(currT), 0, cyan);

  Vector3D T = new Vector3D (-r*sin(currT), r*cos(currT), 0);
  T.draw(X, green);

  Vector3D N = new Vector3D (-r*cos(currT), -r*sin(currT), 0);
  N.draw(X, red);

  Vector3D B = T.cross(N);
  B.scaleBy(T.magnitude()/B.magnitude()).draw(X, magenta);

  currT+=tInc * 20;

  if (currT >= 2 * Math.PI)
    currT = 0;
}

void houseHolder() {
  plotPlane();
  Vector3D v = new Vector3D (0, 0, 400);
  v.draw(cyan);
  v.houseHolder(v).draw(orange);
}

void spiralSphere() {
  float theta = 0, x, y, r;
  pointSize = 2.5;
  for (float z = 0; z <= 2 * SCALE; z+=0.015) {
    r = SCALE * sin (z * PI * 0.5 / SCALE);
    x = r * cos(theta);
    y = r * sin(theta);
    point (x, y, z - SCALE, magenta);
    theta += 0.001;
  }
}

void sphere() {
  pointSize = 2.5;
  for (float theta = 0; theta <= 2*PI; theta += PI/25)
    for (float phi = 0; phi <= PI; phi += PI/500)
      point (SCALE * sin(phi)*cos(theta), SCALE * sin(phi)*sin(theta), SCALE * cos(phi), orange);
}

void circularBackplate() {
  pointSize = 2.5;
  for (float theta = 0; theta <= 2*PI; theta += 0.01)
    for (float r = 0; r <= SCALE; r+=2.5)
      point(r*cos(theta), 0, r*sin(theta), white);
}

void cone() {
  pointSize = 2.5;
  for (float r = SCALE; r >= 0; r-=5)
    for (float theta = 0; theta <= 2*PI; theta += 0.01)
      point(r*cos(theta), r*sin(theta), r, red);
  for (float r = 0; r <= SCALE; r+=5)
    for (float theta = 0; theta <= 2*PI; theta += 0.01)
      point(r*cos(theta), r*sin(theta), -r, blue);
  for (float r = SCALE; r >= 0; r-=5)
    for (float theta = 0; theta <= 2*PI; theta += 0.01)
      point(r, r*cos(theta), r*sin(theta), green);
  for (float r = 0; r <= SCALE; r+=5)
    for (float theta = 0; theta <= 2*PI; theta += 0.01)
      point(-r, r*cos(theta), r*sin(theta), magenta);
}

void paraboloid() {
  pointSize = 0.8;
  for (float x = -SCALE; x <= SCALE; x++)
    for (float y = -SCALE; y <= SCALE; y++)
      point(x, y, 0.002*(x*x + y*y) - SCALE, red);
}


float bound = 1, increment = 0.01 * bound;

void cuboid() {
  for (float x = -bound; x <= bound; x+=increment)
    for (float y = -bound; y <= bound; y+=increment)
      point(x, y, (x*x*x + y*y*y), red);
}

Vector3D ONE = new Vector3D(1, 3, 5), TWO = new Vector3D(2, 4, 6), THREE = new Vector3D(1, 2, 3);
void planeCheck() {
  for (float u = -bound; u <= bound; u+=increment)
    for (float v = -bound; v <= bound; v+=increment)
      point(ONE.scaleBy(u).add(TWO.scaleBy(v)), red);
  pointSize = 20;
  point(THREE, cyan);
}

void plotFunction() {
  pointSize = 1.7 * bound * zoomFactor/200;
  //planeCheck();
  //cuboid();
  //paraboloid();
  //cone();
  //sphere();
  //circularBackplate();
  //spiralSphere();
  //circularPlate();
  //circularMotion();
  //cube();
  if (!plotFunction)
    return;
  //circleOutline();
  pointSize = 100;
  Vector3D vec1 = new Vector3D(400, 0, 0);
  Vector3D vec2 = new Vector3D(-400, 0, 0);
  //Vector3D vec3 = new Vector3D(0, 400, 0);
  if (vec1.y < vec2.y) {
    point(vec1.x, vec1.y, vec1.z, cyan);
    point(vec2.x, vec2.y, vec2.z, magenta);
  } else {
    point(vec2.x, vec2.y, vec2.z, magenta);
    point(vec1.x, vec1.y, vec1.z, cyan);
  }

  textSize(45);
  fill(cyan);
  text("vec1 = "+vec1.getFundamental(), 100, 100);
  fill(magenta);
  text("vec2 = "+vec2.getFundamental(), 100, 150);
  //point(vec3.x, vec3.y, vec3.z, red);

  vec1.minus(vec2).draw(vec2, orange);
  //vec2.minus(vec3).draw(vec3, white);
  //vec3.minus(vec1).draw(vec1, white);

  //for (float u = -200; u <= 200; u+=4)
  //  for (float v = -200; v <= 200; v+=4) {
  //    if (j.y > 0)
  //      point (u, 200, v, color(pink, 255));
  //    else
  //      point (u, 200, v, color(pink, 127));
  //  }
}

void displayIJK() {
  textSize(45);
  text("i = "+i, 100, 100);
  text("j = "+j, 100, 150);
  text("k = "+k, 100, 200);
}

Vector3D test = new Vector3D ();

void r3 () {
  //displayIJK();
  plotFunction();
  //test();
  standard_r3();
  //displayOneTwo();
}

void test() {
  test = i.add(j).add(k).unit().scaleBy(SCALE);
  textSize(45);
  text("Test = "+test, 100, 100);
  test.draw(red);
}

Vector one = new Vector (SCALE, 0), two = new Vector(0, SCALE);

void displayOneTwo() {
  one.draw(white);
  two.draw(orange);
  textSize(45);
  text("1 = "+one, 100, 100);
  text("2 = "+two, 100, 150);
}

void standard_r3() {
  if (!showStandard_r3)
    return;
  j.drawBasis(green);
  i.drawBasis(red);
  k.drawBasis(blue);
  displayMouseCoordinates();
}

float zoomFactor = SCALE/bound;

public void point(float x, float y, float z, color c) {
  Vector3D v1 = i.scaleBy(zoomFactor * x/SCALE);
  Vector3D v2 = j.scaleBy(zoomFactor * y/SCALE);
  Vector3D v3 = k.scaleBy(zoomFactor * z/SCALE);
  v1.add(v2).add(v3).point(c);
}

public void point (Vector3D v, color c) {
  point (v.x, v.y, v.z, c);
}

public void point (Point p, color c) {
  point (p.x, p.y, p.z, c);
}

float mouseX_Change, mouseY_Change, xRotModifier, yRotModifier, zRotModifier;

void mouseMagic_r3() {
  if (!mousePressed)
    return;
  if (mouseMagicCounter++ > mouseMagicWaitTime) {
    mouseX_Change = mouseX - mouseX_0;
    mouseY_Change = mouseY - mouseY_0;
    //performX_magic();
    performY_magic();
    mousePressed();
  }
}

void performX_magic() {
  xRotModifier = -0.00001 * (mouseX() + mouseY());
  rotateX(xRotModifier * mouseX_Change);
  rotateX(xRotModifier * mouseY_Change);
}

void performY_magic() {
  yRotModifier = -0.00001 * (mouseX() + mouseY());
  rotateY(yRotModifier * mouseX_Change);
  rotateY(yRotModifier * mouseY_Change);
}

float mouseMagic_r3_shift = 20, mouseMagicWaitTime = 10, mouseMagicCounter = mouseMagicWaitTime - 1, sensitivity = 0.5;
void old_r3_MouseMagic() {
  if (!mousePressed)
    return;
  if (mouseX >= displayWidth/2.0) {
    if (mouseX + mouseMagic_r3_shift > mouseX_0)
      rotateZ(sensitivity * -0.5 * theta);
    if (mouseX - mouseMagic_r3_shift < mouseX_0)
      rotateZ(sensitivity * 0.5 * theta);
  } else if (mouseX < displayWidth/2.0) {
    if (mouseX + mouseMagic_r3_shift > mouseX_0)
      rotateZ(sensitivity * 0.5 * theta);
    if (mouseX - mouseMagic_r3_shift < mouseX_0)
      rotateZ(sensitivity * -0.5 * theta);
  }
  if (mouseY >= displayHeight/2.0) {
    if (mouseY + mouseMagic_r3_shift > mouseY_0)
      rotateX(sensitivity * 0.5 * theta);
    if (mouseY - mouseMagic_r3_shift < mouseY_0)
      rotateX(sensitivity * -0.5 * theta);
  } else if (mouseY < displayHeight/2.0) {
    if (mouseY + mouseMagic_r3_shift > mouseY_0)
      rotateX(sensitivity * -0.5 * theta);
    if (mouseY - mouseMagic_r3_shift < mouseY_0)
      rotateX(sensitivity * 0.5 * theta);
  }
}
