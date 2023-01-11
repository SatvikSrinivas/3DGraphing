
class Vector {

  float x, y;

  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Vector clone() {
    return new Vector (x, y);
  }

  public void draw() {
    strokeWeight(2.5);
    stroke(255);
    line(getX(0), getY(0), getX(x), getY(y));
  }

  public void draw(color c) {
    strokeWeight(2.5);
    stroke(c);
    line(getX(0), getY(0), getX(x), getY(y));
  }

  public void draw(Vector initialPoint) {
    strokeWeight(2.5);
    stroke(255);
    line(getX(initialPoint.x), getY(initialPoint.y), getX(initialPoint.x + x), getY(initialPoint.y + y));
  }

  public void draw(Vector initialPoint, color c) {
    strokeWeight(2.5);
    stroke(c);
    line(getX(initialPoint.x), getY(initialPoint.y), getX(initialPoint.x + x), getY(initialPoint.y + y));
  }

  public void normalize() {
    this.scaleBy(1.0/magnitude());
  }

  public Vector scale (float f) {
    return new Vector (f * x, f * y);
  }

  public void scaleBy (float f) {
    this.set (f * x, f * y);
  }

  public Vector add (Vector v) {
    return new Vector (x + v.x, y + v.y);
  }

  public void set (Vector v) {
    this.x = v.x;
    this.y = v.y;
  }

  public void set (float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Vector modify (Vector v) {
    return new Vector (x + v.x, y + v.y);
  }

  public void modify (float x, float y) {
    this.x += x;
    this.y += y;
  }

  public Vector apply (Matrix m) {
    return new Vector (m.u.x * x + m.v.x * y, m.u.y * x + m.v.y * y);
  }

  public boolean equals (Vector v) {
    return approxEquals(x, v.x) && approxEquals(y, v.y);
  }

  public boolean equals (float a, float b) {
    return this.equals(new Vector(a, b));
  }

  // angle input in radians counterclockwise rotation
  public void rotate(float theta) {
    float theta_0;
    if (x == 0) {
      if (y > 0)
        theta_0 = (float)Math.PI / 2.0;
      else theta_0 = (float)Math.PI * 1.5 ;
    } else {
      theta_0 = abs(atan(y/x));
      if (y > 0) {
        if (x < 0)
          theta_0 = (float)Math.PI - theta_0;
      } else if (y < 0) {
        if (x < 0)
          theta_0 +=(float)Math.PI;
        else
          theta_0 = (float)Math.PI * 2.0 - theta_0;
      }
    }
    this.set(new Vector(cos(theta_0 + theta), sin(theta_0 + theta)).scale(magnitude()));
  }

  float xAngle() {
    return atan(y/x);
  }

  float magnitude() {
    return sqrt(x * x + y * y);
  }

  String toString() {
    return "<" + round(x) + ", " + round(y) +"> ("+round(magnitude())+")" ;
  }
}

boolean approxEquals (float a, float b) {
  return abs(a - b) < tolerance;
}

class Vector3D {
  float x, y, z;

  public Vector3D() {
  }

  public Vector3D (float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public Vector3D add (Vector3D v) {
    return new Vector3D(x + v.x, y + v.y, z + v.z);
  }

  public Vector3D minus(Vector3D v) {
    return add(v.scaleBy(-1));
  }

  public Vector3D scaleBy (float f) {
    return new Vector3D(f*x, f*y, f*z);
  }

  public float dot(Vector3D v) {
    return x*v.x + y*v.y + z*v.z;
  }

  public Vector3D cross(Vector3D v) {
    return new Vector3D(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
  }

  public void point(color c) {
    plot(x, z, c);
  }

  public void drawBasis (color c) {
    new Vector(x, z).draw(c);
  }

  public Vector3D houseHolder (Vector3D u) {
    Vector3D reflection = u.scaleBy(1/u.magnitude());
    return this.add(reflection.scaleBy(-2 * this.dot(reflection)));
  }

  public void draw() {
    draw(255);
  }

  public void draw(color c) {
    get2D().draw(c);
  }

  public void draw(Vector3D initialPoint, color c) {
    Vector show = get2D();
    Vector init = initialPoint.get2D();
    show.draw(init, c);
  }

  public Vector get2D() {
    Vector3D v1 = i.scaleBy(x/SCALE);
    Vector3D v2 = j.scaleBy(y/SCALE);
    Vector3D v3 = k.scaleBy(z/SCALE);
    Vector3D v = v1.add(v2).add(v3);
    return new Vector(v.x, v.z);
  }

  public Vector3D getFundamental() {
    Vector3D e1 = new Vector3D (1, 0, 0);
    Vector3D e2= new Vector3D (0, 1, 0);
    Vector3D e3 = new Vector3D (0, 0, 1);
    Vector3D v1 = i.scaleBy(x/SCALE);
    Vector3D v2 = j.scaleBy(y/SCALE);
    Vector3D v3 = k.scaleBy(z/SCALE);
    Vector3D v = v1.add(v2).add(v3);
    Vector3D fundamental = e1.scaleBy(v.x).add(e2.scaleBy(v.y)).add(e3.scaleBy(v.z));
    return fundamental;
  }


  public void rotateY (float angle) {
    Vector v = new Vector(x, z);
    v.rotate(angle);
    x = v.x;
    z = v.y;
  }

  public void rotateZ (float angle) {
    Vector v = new Vector(x, y);
    v.rotate(angle);
    x = v.x;
    y = v.y;
  }

  public void rotateX (float angle) {
    Vector v = new Vector(z, y);
    v.rotate(angle);
    z = v.x;
    y = v.y;
  }

  public float magnitude() {
    return (float)(Math.sqrt(x*x + y*y + z*z));
  }

  public Vector3D unit() {
    return this.scaleBy(1/magnitude());
  }

  public String toString() {
    return "<"+round(x)+", "+round(y)+", "+round(z)+"> ("+round(magnitude())+")";
  }
}
