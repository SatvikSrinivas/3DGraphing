
// Math 291: Computing Lab 2 - Satvik Srinivas

float pointSize, tCurrent;

// setting tFinal
float tFinal = 6;

// defines the curve r(t) in terms of x(t), y(t) and z(t)
Vector3D position = new Vector3D();
void curve(float t) {
  position.x = sin(t*t) * (8 * t + 5.36656315);
  position.y = 8.94427191 * t*t + 6 * t;
  position.z = cos(t*t) * (8 * t + 5.36656315);
}

// plots points on the curve from t = 0 to t = tFinal
void plotCurve() {
  pointSize = 2;
  for (float t = 0; t <= tFinal; t += 0.0001) {
    curve(t); // sets the position vector based on the parameter t
    point(position.x, position.y, position.z, orange);
  }
}

boolean showPositionVector, animateCurve;

void animatePointAlongCurve() {
  if (!animateCurve)
    return;

  curve(tCurrent);  // <- sets values of x, y, and z based on the current t
  pointSize = 15;
  point(position.x, position.y, position.z, cyan);

  // increments value of tCurrent
  tCurrent += 0.025;
  // sets tCurrent back to 0 if it reaches tFinal
  if (tCurrent >= tFinal)
    tCurrent = 0;
}

// sets values of x, y, and z for x'(t)
Vector3D velocity = new Vector3D();
void velocity(float t) {
  velocity.x = 8 * sin(t*t) + 2 * t * cos(t*t) * (8 * t + 5.36656315);
  velocity.y = 17.8885438 * t + 6;
  velocity.z = 8 * cos(t*t) - 2 * t * sin(t*t) * (8 * t + 5.36656315);
}

float curveLength(float a, float b) {
  float curveLength = 0;
  for (float t = a; t <= b; t += 0.001) {
    velocity(t); // sets the velocity vector based on the parameter t
    curveLength += velocity.magnitude() * 0.001;
  }
  return curveLength;
}

boolean showTangentVector;

Vector3D tangent(float t) {
  velocity(t);
  return velocity;
}

Vector3D unitTangent(float t) {
  return tangent(t).unit();
}

void showTangentVector() {
  if (!showTangentVector)
    return;
  curve(tCurrent);
  velocity(tCurrent);
  unitTangent(tCurrent).scaleBy(100).draw(position, green);
}

// sets values of x, y, and z for x''(t)
Vector3D acceleration = new Vector3D(0, 17.8885438, 0);
void acceleration(float t) {
  acceleration.x = 32 * t * cos(t*t) + 2 * (cos(t*t) - 2*t*t*sin(t*t)) * (8 * t + 5.36656315);
  // acceleration.y is constant and equal to 8 * sqrt(5) = 17.8885438 so it is not constantly updated to eliminate redundancy
  acceleration.z = -(32 * t * sin(t*t) + 2 * (sin(t*t) - 2*t*t*cos(t*t)) * (8 * t + 5.36656315));
}

Vector3D unitNormal (float t) {
  Vector3D T = unitTangent(t);
  acceleration(t);
  return acceleration.add(T.scaleBy(-acceleration.dot(T))).unit();
}

boolean showNormalVector;
void showNormalVector() {
  if (!showNormalVector)
    return;
  acceleration(tCurrent);
  Vector3D N = unitNormal(tCurrent);
  curve(tCurrent);
  N.scaleBy(100).draw(position, magenta);
}

Vector3D binormal(float t) {
  Vector3D T = unitTangent(t);
  Vector3D N = unitNormal(t);
  return T.cross(N);
}

boolean showBinormalVector;
void showBinormalVector() {
  if (!showBinormalVector)
    return;
  curve(tCurrent);
  binormal(tCurrent).scaleBy(100).draw(position, red);
}

float curvature(float t) {
  velocity(t);
  acceleration(t);
  return velocity.cross(acceleration).magnitude()/
    ((float)Math.pow(velocity.magnitude(), 3));
}

void lab() {
  if (showPositionVector)
    position.draw(white);
  showNormalVector();
  plotCurve();
  animatePointAlongCurve();
  showTangentVector();
  showBinormalVector();
  fill(yellow);
  textSize(50);
  text("K = "+curvature(tCurrent), displayWidth * 0.05, displayHeight * 0.1);
  new Vector(0, 20000 * curvature(tCurrent)).draw(new Vector(-0.9 * displayWidth/2, -0.9 * displayHeight/2), yellow);
}

void labOutput() {
  println("curveLength(0,tFinal) = "+curveLength(0, tFinal));
  println("tangent(0) : " + tangent(0));
  println("tangent(tFinal) : "+tangent(tFinal));
  println("unitTangent(0) : "+unitTangent(0));
  println("unitTangent(tFinal) : "+unitTangent(tFinal));
  println("unitNormal(0) : "+unitNormal(0));
  println("unitNormal(tFinal) : "+unitNormal(tFinal));
  println("binormal(0) : "+binormal(0));
  println("binormal(tFinal) : "+binormal(tFinal));
  println("curvature(0) : "+curvature(0));
  println("curvature(tFinal) : "+curvature(tFinal));
}
