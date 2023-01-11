
void view() {
  baseSphere(10);
  standard_r3();
  //holidayPlane();
}

void baseSphere(float R) {
  float r, x, y, z, Rsquared = R * R;
  for (float theta = 0; theta <= 2*PI; theta += 0.05)
    for (float phi = 0; phi <= PI; phi += 0.05) {
      z = R * cos(phi);
      r = R * sin(phi);
      x = r * cos(theta);
      y = r * sin(theta);
      if (x * x + y * y + z * z <= Rsquared)
        point3D(x, y, z, white);
    }
}

void basePlane() {
  for (float i = -1; i <= 1; i+=0.005)
    for (float j = -1; j <= 1; j+=0.005)
      point3D(i, j, 0, white);
}

void point3D(float x, float y, float z, color c) {
  Vector3D v1 = i.scaleBy(zoomFactor * x/SCALE);
  Vector3D v2 = j.scaleBy(zoomFactor * y/SCALE);
  Vector3D v3 = k.scaleBy(zoomFactor * z/SCALE);
  Vector3D v = v1.add(v2).add(v3);
  point(displayWidth/2+(int)v.x, displayHeight/2+(int)v.z, c);
}

float pointRadius = 2, pointRadiusSquared = pointRadius * pointRadius;
void point (float x, float y, color c) {
  float xDist, yDist;
  for (float i = x - pointRadius; i <= x + pointRadius; i ++)
    for (float j = y - pointRadius; j <= y + pointRadius; j++) {
      xDist = i - x;
      yDist = j - y;
      if (xDist * xDist + yDist * yDist <= pointRadiusSquared)
        set((int)i, (int)j, c);
    }
}


boolean holidayPlane_zoomDir = true;
int holidayPlane_zoomDirCount = 0;

void holidayPlane() {
  pointSize = 2.5;
  boolean change = true;
  int count = 0;
  for (float u = 0; u <= 1; u+=0.005)
    for (float v = 0; v <= 1; v+=0.005) {
      if (change) {
        point (u, v, 0, yellow);
        point (u, -v, 0, blue);
        point (-u, v, 0, red);
        point (-u, -v, 0, orange);
      } else {
        point (u, v, 0, pink);
        point (u, -v, 0, cyan);
        point (-u, v, 0, green);
        point (-u, -v, 0, magenta);
      }
      if (count++ > 100) {
        change = !change;
        count = 0;
      }
    }

  if (holidayPlane_zoomDir)
    zoomFactor *= 1.08;
  else
    zoomFactor /= 1.08;
  if (holidayPlane_zoomDirCount++ > 100) {
    holidayPlane_zoomDir = !holidayPlane_zoomDir;
    holidayPlane_zoomDirCount = 0;
  }
  rotateY(theta/2);
}
