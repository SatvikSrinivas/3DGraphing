
float scale = 400, halfScale = scale/2, rad3 = halfScale * sqrt(3), phi = 0, shift = 40;
Vector U = new Vector (-rad3, -halfScale), V = new Vector (rad3, -halfScale), W = new Vector(0, scale),
  U_ = U.scale(-1), V_ = V.scale(-1), W_ = W.scale(-1);


Vector3D v1 = new Vector3D (0.3 * scale, 0, 0);
Vector3D v2 = new Vector3D (0, -0.3 * scale, scale);
Vector3D U3D = new Vector3D (scale, 0, 0), V3D = new Vector3D(0, scale, 0), W3D = new Vector3D(0, 0, scale);

void space() {
  view();
}

float tSpiral = -8 * (float) Math.PI, tShift = 0.0575;
void spiralAnimation() {
  for (float t = -8 * (float) Math.PI; t < tSpiral; t += tShift)
    plot(50 * cos(t), 50 * sin(t), 10 * t);
  tSpiral += tShift;
}

void spiral() {
  for (float t = - 8 * (float) Math.PI; t <= 8 * Math.PI; t += 0.001)
    plot(50 * cos(t), 50 * sin(t), 10 * t);
}

void defaultAxes() {
  U.draw();
  fill (255, 0, 0);
  textSize(48);
  text("x", getX(U.x) - shift, getY(U.y) + shift);
  V.draw();
  textSize(50);
  text("y", getX(V.x) + 0.5 * shift, getY(V.y) + 0.875 * shift);
  W.draw();
  text("z", getX(W.x) - 0.25 * shift, getY(W.y) - 0.75 * shift);
  U_.draw();
  V_.draw();
  W_.draw();
}

void plane(Vector3D initPoint, Vector3D dir1, Vector3D dir2) {
  for (float s = -1; s < 1; s += 0.01)
    for (float t = -1; t < 1; t += 0.01)
      plot(initPoint.add(dir1.scaleBy(s)).add(dir2.scaleBy(t)));
}

void line (Vector3D initPoint, Vector3D direction) {
  for (float t = -1; t < 1; t += 0.01)
    plot(initPoint.add(direction.scaleBy(t)));
}

void plot (Vector3D v) {
  Vector display = get2D(v.x, v.y, v.z);
  plot (display, color(255, 165, 0, 150));
}

void plot(float x, float y, float z) {
  plot (get2D(x, y, z), color (255, 165, 0));
}

void standardPlane() {
  line(getX(U.x), getY(U.y), getX(V_.x), getY(V_.y));
  line(getX(V.x), getY(V.y), getX(U_.x), getY(U_.y));
  line(getX(U.x), getY(U.y), getX(V.x), getY(V.y));
  line(getX(V_.x), getY(V_.y), getX(U_.x), getY(U_.y));
}

Vector get2D (float x, float y, float z) {
  Vector[] components = get2D_Components(x, y, z);
  return components[0].add(components[1]).add(components[2]);
}

void draw (Vector[] vArr) {
  vArr[0].draw(color(255, 0, 0));
  vArr[1].draw(color(0, 255, 0));
  vArr[2].draw(color(0, 0, 255));
}

Vector[] get2D_Components(float x, float y, float z) {
  x /= scale;
  y /= scale;
  z /= scale;
  return new Vector[] {U.scale(x), V.scale(y), W.scale(z)};
}
