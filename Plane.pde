
class Plane {

  Vector u, v, u_0, v_0, u_f, v_f, t_0, t_f;
  float dim = 400;
  boolean transform = false;
  Matrix m, currentState;

  public Plane (Vector u, Vector v) {
    this.u = u;
    this.v = v;
    currentState = new Matrix (I, J);
  }

  public void set (Vector u, Vector v) {
    this.u = u;
    this.v = v;
  }

  float size = 0.5, interval = 80;  

  public void grid() {
    if (transform) {
      u.modify(uXIncrement, uYIncrement);
      v.modify(vXIncrement, vYIncrement);
      t.modify(tXIncrement, tYIncrement);
      if (transformationComplete()) {
        transform = false;
        u.set(u_f);
        v.set(v_f);
        t.set(t_f);
        currentState = currentState.multiply(m);
        m = null;
        index++;
        initiateZoomDataReset(new Vector[] {u, v});
      }
    }
    for (float i = -size * dim; i <= size * dim; i += interval)
      vGridLine(i);
    for (float j = -size * dim; j <= size * dim; j += interval)
      uGridLine(j);
    showBasisVectors();
  }

  void showBasisVectors() {
    u.scale(scaleFactor).draw(color(255, 0, 144));
    v.scale(scaleFactor).draw(color(0, 255, 0));
    if (showTestVector)
      t.scale(scaleFactor).draw(color(0, 181, 226));
  }

  public void vGridLine(float a) {
    for (float b = -size * dim; b <= size * dim; b++)
      plot(u.scale(a).add(v.scale(b)));
  }

  public void uGridLine(float b) {
    for (float a = -size * dim; a <= size * dim; a++)
      plot(u.scale(a).add(v.scale(b)));
  }

  // fix size reduction bug
  public Vector[] getDestinationVectors(Matrix m) {
    Vector i_0 =  new Vector (I.magnitude() * cos(gridAngle), I.magnitude() * sin(gridAngle)), 
      j_0 = new Vector (J.magnitude() * sin(gridAngle), J.magnitude() * cos(gridAngle));
    return new Vector[] {new Vector (i_0.apply(m).x, i_0.apply(m).y), new Vector (j_0.apply(m).x, j_0.apply(m).y), i_0, j_0};
  }

  public float[] getIncrementValues(Matrix m) {
    return new float[] {(u.clone().apply(m).x - u.x) / numOfSteps, (u.clone().apply(m).y - u.y) / numOfSteps, 
      (v.clone().apply(m).x - v.x) / numOfSteps, (v.clone().apply(m).y - v.y) / numOfSteps};
  }

  float uXIncrement, uYIncrement, vXIncrement, vYIncrement, tXIncrement, tYIncrement; 
  public void apply(Matrix mat) {
    if (m != null && transformationComplete() || transform)
      return;
    transform = true;
    m = mat;
    u_0 = u.clone();
    v_0 = v.clone();
    u_f = u_0.apply(m);
    v_f = v_0.apply(m);
    t_0 = t.clone();
    t_f = t_0.apply(m);
    uXIncrement = (u_f.x - u.x) / numOfSteps;
    uYIncrement = (u_f.y - u.y) / numOfSteps;
    vXIncrement = (v_f.x - v.x) / numOfSteps;
    vYIncrement = (v_f.y - v.y) / numOfSteps;
    tXIncrement = (t_f.x - t.x) / numOfSteps;
    tYIncrement = (t_f.y - t.y) / numOfSteps;
  }

  public void apply(AnimationList list) {
    if (index < list.size()) 
      apply(list.get(index));
  }

  boolean transformationComplete() {
    return u.equals(u_f) && v.equals(v_f);
  }

  public String toString() {
    return u.toString() + "\n" + v.toString();
  }

  public void reset() {
    u.set(1, 0);
    v.set(0, 1);
    u_0 = null;
    v_0 = null;
    u_f = null;
    v_f = null;
    t.set(testVector);
    t_0 = null;
    t_f = null;
  }

  public Matrix inverse() {
    return currentState.inverse();
  }

  public void showDestinationVectors() {
    if (index < matList.size() && u_f != null && v_f != null) {
      u_f.scale(scaleFactor).draw(color(0, 255, 255));
      v_f.scale(scaleFactor).draw(color(255, 127, 0));
    }
  }
}
