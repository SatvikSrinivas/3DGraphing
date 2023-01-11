
class Matrix {

  Vector u, v;

  public Matrix (Vector u, Vector v) {
    this.u = u;
    this.v = v;
  }

  public Matrix (float a, float b, float c, float d) {
    u = new Vector (a, c);
    v = new Vector (b, d);
  }

  public boolean equals(Matrix m) {
    return u.equals(m.u) && v.equals(m.v);
  }

  public float det() { 
    float a = u.x, b = v.x, c = u.y, d = v.y;
    return a * d - b * c;
  }

  public Matrix multiply (Matrix m) {
    float a = u.x, b = v.x, c = u.y, d = v.y, e = m.u.x, f = m.v.x, g = m.u.y, h = m.v.y;
    return new Matrix (a*e + c*f, b*e + d*f, a*g + c*h, b*g + d*h);
  }

  public Matrix multiply (float e, float f, float g, float h) {
    float a = u.x, b = v.x, c = u.y, d = v.y;
    return new Matrix (a*e + c*f, b*e + d*f, a*g + c*h, b*g + d*h);
  }

  public Matrix inverse () {
    float a = u.x, b = v.x, c = u.y, d = v.y, det = a*d-b*c;
    return new Matrix (d/det, -b/det, -c/det, a/det);
  }

  public boolean aEqualsNegD() {
    return approxEquals(u.x, -v.y);
  }

  public boolean aSquaredPlusBCEquals1() {
    float a = u.x, b = v.x, c = u.y;
    return a*a+b*c == 1;
  }

  public boolean BCPlusDSquaredEquals1() {
    float b = v.x, c = u.y, d = v.y;
    return b*c+d*d == 1;
  }

  public String toString () {
    return "|"+u.x+" "+v.x+"|\n|"+u.y+" "+v.y+"|\n"+"det() = "+det();
  }
}

float scalarNum = 5;

Matrix randomMatrix() {
  return new Matrix (new Vector(random(-scalarNum, scalarNum), random(-scalarNum, scalarNum)), new Vector(random(-scalarNum, scalarNum), random(-scalarNum, scalarNum)));
}

Matrix randomReflexiveMatrix() {
  float a = random(-scalarNum, scalarNum), b = random(-scalarNum, scalarNum);
  return new Matrix (a, b, (1-a*a)/b, -a);
}

Matrix reflexiveMatrix(float a, float b, float c) {
  return new Matrix (a, b, c, (b*c-1)/a);
}

Matrix scaleMatrix (float f) {
  return new Matrix (f, 0, 0, f);
}

class Matrix_3x3 {
  Vector3D u, v, w;

  public Matrix_3x3 (Vector3D u, Vector3D v, Vector3D w) {
    this.u = u;
    this.v = v;
    this.w = w;
  }

  public Matrix_3x3 (float a, float b, float c, float d, float e, float f, float g, float h, float i) {
    u = new Vector3D (a, d, g);
    v = new Vector3D (b, e, h);
    w = new Vector3D (c, f, i);
  }

  public String toString () {
    return "|"+u.x+" "+v.x+" "+w.x+"|\n|"+u.y+" "+v.y+" "+w.y+"|\n|"+u.z+" "+v.z+" "+w.z+"|";
  }
}

public Matrix_3x3 multiply (Matrix_3x3 one, Matrix_3x3 two) {
  float a = one.u.x, b = one.v.x, c = one.w.x, d = one.u.y, e = one.v.y, f = one.w.y, g = one.u.z, h = one.v.z, i = one.w.z, 
    j = two.u.x, k = two.v.x, l = two.w.x, m = two.u.y, n = two.v.y, o = two.w.y, p = two.u.z, q = two.v.z, r = two.w.z;
  return new Matrix_3x3(j*a+k*d+l*g, j*b+k*e+l*h, j*c+k*f+l*i, 
    m*a+n*d+o*g, m*b+n*e+o*h, m*c+n*f+o*i, 
    p*a+q*d+r*g, p*b+q*e+r*h, p*c+q*f+r*i);
}
