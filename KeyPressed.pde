
final String validNumberInputs = "0123456789";
String numberInput = "";

void keyPressed () {
  switch (key) {
  case '1':
    showStandard_r3 = !showStandard_r3;
    break;
  case '2':
    plotFunction = !plotFunction;
  case 'p':
    showPositionVector = !showPositionVector;
    break;
  case 't':
    showTangentVector = !showTangentVector;
    break;
  case 'n':
    showNormalVector = !showNormalVector;
    break;
  case 'b':
    showBinormalVector = !showBinormalVector;
    break;
  case 'a':
    animateCurve = !animateCurve;
    break;
  case 'm':
    showMouseCoordinates = !showMouseCoordinates;
    break;
  case ' ':
    //start = true;
    one.rotate(theta);
    two.rotate(theta);
    break;
  case 'c':
    println("Console Info:");
    println("Grid Angle: "+gridAngle + " = "+round((float)(gridAngle * (180.0 / Math.PI))));
    //printAnimationData();
    println();
    break;
  case 'r':
    //keyPressed_r();
    one.set(SCALE, 0);
    two.set(0, SCALE);
    break;
  case 'q':
    setAnimationInformation();
    horiz = !horiz;
    vert = !vert;
    break;
  case 'z':
    showZTrace = !showZTrace;
    break;
  }
  if (validNumberInputs.contains(""+key))
    numberInput += key;
  switch (keyCode) {
  case ENTER:
    number = Integer.valueOf(numberInput) - 1;
    if (number >= rSeries.size())
      return;
    numberInput = "";
    keyPressed_r();
    start = true;
    break;
  case BACKSPACE:
    if (numberInput.length() == 0)
      return;
    numberInput = numberInput.substring(0, numberInput.length() - 1);
    break;
  case RIGHT:
    rotateZ(-theta);
    break;
  case LEFT:
    rotateZ(theta);
    break;
  case UP:
    rotateX(-theta);
    break;
  case DOWN:
    rotateX(theta);
    break;
  case '=':
    zoomFactor *= 1.1;
    break;
  case '-':
    zoomFactor /= 1.1;
    break;
  case '[' :
    rotateY(theta);
    break;
  case ']' :
    rotateY(-theta);
    break;
  case ',':
    zoom(false);
    break;
  case '.':
    zoom(true);
    break;
  }
}

void setMatList() {
  p.reset();
  index = 0;
  matList = new AnimationList();
}

void keyPressed_setMatList() {
  if (p.transform)
    return;
  setMatList();
}

void keyPressed_r() {
  keyPressed_setMatList();
  start = false;
  setAnimationInformation();
}

void keyPressed_Right() {
  keyPressed_setMatList();
  start = true;
}

Matrix currentMat = randomMatrix(), rotation = new Matrix (0, -1, 1, 0), shear = new Matrix (1, 1, 0, 1),
  reset = new Matrix (1, 0, 0, 1), combo = new Matrix (1, -1, 1, 0),
  m1 = new Matrix (1, -2, 1, 0), m2 = new Matrix (0, 2, 1, 0);
Matrix a = new Matrix (0, 1, 1, 0), b = new Matrix (1, 0, 0, 1), c = a.multiply(b);
Matrix shrink = new Matrix (0.1, 0, 0, 0.1);
