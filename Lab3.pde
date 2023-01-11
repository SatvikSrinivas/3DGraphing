
// Math 291: Computing Lab 3 - Satvik Srinivas

float fOfXY(float x, float y) {
  return 2*y*y - 6*y - x*y - 5*x*x - 4*x + 3;
}

boolean showZTrace = false;

void f() {
  for (float x = -bound; x <= bound; x+=increment)
    for (float y = -bound; y <= bound; y+=increment) {
      point(x, y, 2*y*y - 6*y - x*y - 5*x*x - 4*x + 3, orange);
      if (showZTrace)
        point(x, y, 0, magenta);
    }
}

float z;

void sketchOfCurveSatisfying_fOfXYequals0() {
  for (float x = -bound; x <= bound; x+=0.01)
    for (float y = -bound; y <= bound; y+=0.01) {
      z = 2*y*y - 6*y - x*y - 5*x*x - 4*x + 3;
      if (abs(z) <  0.0045 * 15)
        point(x, y, z, cyan);
    }
}

void sketchOfCurveSatisfying_fOfXYequals0_bestFitLines() {
  pointSize = 2.25;
  for (float x = bound; x >= -bound; x-=0.0009)
    for (float y = -bound; y <= bound; y+=0.0009) {
      if (approxEquals(y, -1.35*x + 0.65) || approxEquals(y, 1.85*x + 2.2))
        point(x, y, 0, magenta);
    }
}

boolean first = true;

final float A = -3.1;

void computePointsAyOnTheCurve() {
  pointSize = 20;
  float x = A;
  for (float y = -bound; y <= bound; y+=0.01) {
    z = 2*y*y - 6*y - x*y - 5*x*x - 4*x + 3;
    if (abs(z) <  0.0045 * 15) {
      point(x, y, z, yellow);
      fill(orange);
      textSize(40);
      if (y == -3.3798635) {
        text ("("+x+", "+"-3.38"+")", getX(-129 + 0.5 * shift), getY(-209 + shift));
        fill (magenta);
        textSize(30);
        text ("y = 1.85x + 2.2", getX(-380 + 0.5 * shift), getY(-209 + shift));
      } else {
        text ("("+x+", "+4.83+")", getX(-280 - 0.5 * shift), getY(89 + shift));
        fill (magenta);
        textSize(30);
        text ("y = -1.35x + 0.65", getX(-350 - 0.5 * shift), getY(180 + shift));
      }
    }
  }
}

void lab3_f() {
  f();
  sketchOfCurveSatisfying_fOfXYequals0();
  computePointsAyOnTheCurve();
  sketchOfCurveSatisfying_fOfXYequals0_bestFitLines();
}

ArrayList<Point> gPoints;
float g;
PrintWriter output;

void lab3_gSetup() {
  pointSize = 1.7 * bound * zoomFactor/200;
  long start = System.currentTimeMillis();
  increment = 0.001;
  gPoints = new ArrayList<Point>();
  output = createWriter("gPoints2.txt");
  for (float x = -bound; x <= bound; x += increment)
    for (float y = -bound; y <= bound; y += increment)
      for (float z = -bound; z <= bound; z += increment) {
        g = 3*x + 4*y -2*z -2*x*y + 5*x*z +4*y*z + 2*x*x + 2*y*y -6*z*z + 2;
        if (approxEquals(g, 0)) {
          gPoints.add (new Point(x, y, z));
          output.println(x + "," + y + ","+z);
        }
      }
  output.close();
  println("lab3_gSetup() : COMPLETE");
  println("TIME : "+(System.currentTimeMillis() - start) / 1000 +"s");
}

void lab3_gLoad() {
  pointSize = 1.7 * bound * zoomFactor/200;
  gPoints = new ArrayList<Point>();
  String[] lines = loadStrings("gPoints2.txt"), data;
  float x, y, z;
  for (int i = 0; i < lines.length; i++) {
    data = lines[i].split(",");
    x = (float)(Double.parseDouble(data[0]));
    y = (float)(Double.parseDouble(data[1]));
    z = (float)(Double.parseDouble(data[2]));
    gPoints.add (new Point(x, y, z));
  }
}

final float B = 1.5, C = 0.6;
void computePointsInTheFormBCz() {
  float x = B, y = C;
  for (float z = -bound; z <= bound; z += 0.000001) {
    g = 3*x + 4*y -2*z -2*x*y + 5*x*z +4*y*z + 2*x*x + 2*y*y -6*z*z + 2;
    if (approxEquals(g, 0))
      println(x+","+y+","+z);
  }
}

void g() {
  for (Point p : gPoints) {
    pointSize = 1.7 * bound * zoomFactor/200;
    point(p, color(magenta, 100));
    if (abs(p.x - B) < 0.01 || abs(p.y - C) < 0.01) {
      pointSize = 15;
      point(p, color(white));
    }
  }
}

void plane (float x_0, float y_0, float z_0, float f_x, float f_y, color c) {
  for (float u = -bound; u <= bound; u+=increment)
    for (float v = -bound; v <= bound; v+=increment)
      point (u + x_0, v + y_0, f_x*u + f_y*v + z_0, c);
}

void plane1() {
  for (float x = -bound; x <= bound; x += increment)
    for (float y = -bound; y <= bound; y += increment)
      point (x, y, (2*y - 4*x - 3)/5, color(yellow, 127));
}

void plane2() {
  for (float x = -bound; x <= bound; x += increment)
    for (float y = -bound; y <= bound; y += increment)
      point (x, y, (2*x - 4*y - 4)/4, color(cyan, 127));
}

void lab3_output() {
  println("Points in the form (B, C, z) on the surface:");
  println("(1.5, 0.6, -0.9186063)");
  println("(1.5, 0.6, 2.2352726)");
}

float Gx(float x, float y, float z) {
  return (-4*x -5*z - 3) / (5*x + 4*y -12*z - 2);
}

float Gy(float x, float y, float z) {
  return (-4*y -4*z - 4) / (5*x + 4*y -12*z - 2);
}

void lab3() {
  //plane1();
  //plane2();
  g();

  plane(B, C, -0.9186, -0.2328, -0.1440, color (red, 120));
  plane(B, C, 2.2352, 1.066, 0.8106, color (blue, 120));
}
