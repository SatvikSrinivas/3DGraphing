
class AnimationList {
  String name = "NO NAME";
  ArrayList<Matrix> animationList;
  public AnimationList() {
    animationList = new ArrayList<Matrix>();
  }
  public void add (Matrix m) {
    animationList.add(m);
  }
  public void add (Matrix m, int n) {
    for (int i = 0; i < n; i++)
      animationList.add(m);
  }
  public void add (float a, float b, float c, float d) {
    add(new Matrix(a, b, c, d));
  }
  public int size() {
    return animationList.size();
  }
  public Matrix get(int i) {
    return animationList.get(i);
  }
  public String toString() {
    String toString = "", line;
    boolean rSeries = false;
    Matrix currentAnimation;
    for (int i = 0; i < animationList.size(); i++) {
      currentAnimation = animationList.get(i);
      line = (i+1)+"#:\n"+currentAnimation.toString();
      if (name.equals(rSeriesName)) {
        rSeries = true;
        line += "\n(a,d) = "+(currentAnimation.aEqualsNegD())+"\na^2 + bc = "
          +currentAnimation.aSquaredPlusBCEquals1()+"\n"+
          "bc + d^2 = "+currentAnimation.BCPlusDSquaredEquals1();
      }
      line += "\n\n";
      if (rSeries)
        rInfo.add(line);
      toString += line;
    }
    return toString;
  }
}

void zoom (boolean in) {
  if (in) {
    p.apply(new Matrix(zoom, 0, 0, zoom));
    zoomLevel++;
  } else {
    p.apply(new Matrix(1/zoom, 0, 0, 1/zoom));
    zoomLevel--;
  }
}

Vector[] zoomDestinations;
boolean resetZoomData = false;
void initiateZoomDataReset(Vector[] vArr) {
  zoomDestinations = vArr;
  resetZoomData = true;
}

int resetZoomCounter = -1;
void resetZoomData() {
  if (!resetZoomData)
    return;
  if (++resetZoomCounter > 50) {
    setAnimationInformation();
    resetZoomData = false;
  }
}

void spin (float angle) {
  gridAngle += angle;
  u.rotate(angle);
  v.rotate(angle);
  setAnimationInformation();
}

// optimize the circle function
void circle (float r) {
  Vector plottingVector = new Vector (1, 0).scale(r);
  float angleIncrement = 0.0001;
  for (float angle = 0; angle <= (float) Math.PI * 2; angle += angleIncrement) {
    plot(plottingVector);
    plottingVector.rotate(angleIncrement);
  }
}

void clock() {
  stroke(255, 0, 0);
  circle (displayWidth/2.0, displayHeight/2.0, 500);
  u.draw();
  v.draw();
  u.rotate(-theta);
  v.rotate(-60 * theta);
}
