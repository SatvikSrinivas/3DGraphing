
void setup() {
  fullScreen();
  setMatList();
  //showInfo = true;
  //showTestVector = true;
  if (showTestVector) {
    testVector.normalize();
    t = testVector.clone();
  }
  theta = (float)(Math.PI/64);
  alpha = 0;
  setAnimationInformation();
  setup_r3();
  USA();
  mouseX();
  setupCircularPlate();
  //lab3_gSetup();
  lab3_gLoad();
  //lab3_output();
  //rotateX(PI/2);
}

boolean start = false, runRSeries = false, showInfo = false, showTestVector = false, animating = false;
int index, number = 0, zoomLevel = 0;
float u_x = 1, u_y = 0, change = 0.03125, theta, alpha, beta, scaleFactor = 250, animationSpeed = 2
  , numOfSteps =  100 / animationSpeed, gridAngle = 0, zoom = 2.5;
Vector u = new Vector (1, 0), v = new Vector (0, 1), testVector = new Vector (sqrt(2), sqrt(2)), t = new Vector (0, 0);
final Vector I = new Vector (1, 0), J = new Vector (0, 1);
Plane p = new Plane (u, v);
AnimationList matList;
double tolerance = animationSpeed * Math.pow(10, -5);
float mouseX_0, mouseY_0, mouseSensitivity = 2.5, mouseWaitTime = 1, mouseTime = 0, magicalTolerance = 100;

void mousePressed() {
  mouseX_0 = mouseX;
  mouseY_0 = mouseY;
}

boolean rotatingAboutZ, rotatingAboutY;

void displayAngleData() {
  textSize(50);
  fill(255);
  float vertShift = 70;
  text("gridAngle = "+gridAngle, 10, 55);
  text("alpha = "+alpha, 10, 55 + vertShift);
  text("u.xAngle() = "+u.xAngle(), 10, 55 + 2*vertShift);
  text("v.xAngle() = "+v.xAngle(), 10, 55 + 3*vertShift);
  text("rotatingAboutY = "+rotatingAboutY, 10, 55 + 4*vertShift);
  text("rotatingAboutZ = "+rotatingAboutZ, 10, 55 + 5*vertShift);
}

void draw() {
  background(0);
  //draw2D();
  draw3D();
  old_r3_MouseMagic();
}

void rotationalMethod() {
  if (rotatingAboutY) {
    //u.x = cos(gridAngle)*cos(alpha);
    //v.x = -sin(gridAngle)*cos(alpha);
    u.x = cos(u.xAngle())*cos(alpha);
    v.x = -cos(v.xAngle())*cos(alpha);
  }
  displayAngleData();
  //mouseMagic();
  resetZoomData();
}

boolean forwards_horiz = true, forwards_vert = true;
float mouseTolerance = 200;

float[] horizontalIncrementData, verticalIncrementData;
Vector[] horizontalDestinationData, verticalDestinationData;

void setAnimationInformation() {
  horizontalDestinationData = p.getDestinationVectors(new Matrix(-1, 0, 0, 1));
  verticalDestinationData = p.getDestinationVectors(new Matrix(1, 0, 0, -1));
  horizontalIncrementData = p.getIncrementValues(new Matrix(-1, 0, 0, 1));
  verticalIncrementData = p.getIncrementValues(new Matrix(1, 0, 0, -1));
}

void mouseMagic() {
  if (mousePressed) {
    if (p.transform)
      return;
    if (mouseTime < mouseWaitTime)
      mouseTime++;
    else {
      mousePressed();
      mouseTime = 0;
    }

    if (horiz)
      horizontalMouseMagic();
    if (vert)
      verticalMouseMagic();
  } else {
    forwards_horiz = true;
    forwards_vert = true;
  }
}

boolean horiz = false, vert = true;
float magicMouseBuffer = 1;

void horizontalMouseMagic() {
  if (mouseX > mouseX_0 + magicMouseBuffer) {
    if (forwards_horiz) {
      if (!u.equals(horizontalDestinationData[0])) {
        u.x +=  mouseSensitivity * horizontalIncrementData[0];
        v.x += mouseSensitivity * horizontalIncrementData[2];
      }
    } else {
      if (!u.equals(horizontalDestinationData[2])) {
        u.x -=  mouseSensitivity * horizontalIncrementData[0];
        v.x -= mouseSensitivity * horizontalIncrementData[2];
      }
    }
    if ((u.equals(horizontalDestinationData[0]) || u.equals(horizontalDestinationData[2])))
      forwards_horiz = !forwards_horiz;
  }

  if (mouseX < mouseX_0 - magicMouseBuffer) {
    if (forwards_horiz) {
      if (!u.equals(horizontalDestinationData[2])) {
        u.x -=  mouseSensitivity * horizontalIncrementData[0];
        v.x -= mouseSensitivity * horizontalIncrementData[2];
      }
    } else {
      if (!u.equals(horizontalDestinationData[0])) {
        u.x +=  mouseSensitivity * horizontalIncrementData[0];
        v.x += mouseSensitivity * horizontalIncrementData[2];
      }
    }
    if (u.equals(horizontalDestinationData[0]) || u.equals(horizontalDestinationData[2]))
      forwards_horiz = !forwards_horiz;
  }
}

void verticalMouseMagic() {
  if (mouseY > mouseY_0 + magicMouseBuffer) {
    if (forwards_vert) {
      if (!v.equals(verticalDestinationData[1])) {
        u.y +=  mouseSensitivity * verticalIncrementData[1];
        v.y += mouseSensitivity * verticalIncrementData[3];
      }
    } else {
      if (!v.equals(verticalDestinationData[3])) {
        u.y -=  mouseSensitivity * verticalIncrementData[1];
        v.y -= mouseSensitivity * verticalIncrementData[3];
      }
    }
    if (v.equals(verticalDestinationData[1]) || v.equals(verticalDestinationData[3]))
      forwards_vert = !forwards_vert;
  }

  if (mouseY < mouseY_0 - magicMouseBuffer) {
    if (forwards_vert) {
      if (!v.equals(verticalDestinationData[3])) {
        u.y -=  mouseSensitivity * verticalIncrementData[1];
        v.y -= mouseSensitivity * verticalIncrementData[3];
      }
    } else {
      if (!v.equals(verticalDestinationData[1])) {
        u.y +=  mouseSensitivity * verticalIncrementData[1];
        v.y += mouseSensitivity * verticalIncrementData[3];
      }
    }
    if (v.equals(verticalDestinationData[1]) || v.equals(verticalDestinationData[3]))
      forwards_vert = !forwards_vert;
  }
}

void printAnimationData() {
  println(new Vector[]{u, v});
  println("\nHorizontal:");
  println(horizontalDestinationData);
  println(horizontalIncrementData);
  println("\nVertical:");
  println(verticalDestinationData);
  println(verticalIncrementData);
}

void draw3D() {
  //space();
  //r3();
  lab3();
  standard_r3();
}

void draw2D() {
  //p.showDestinationVectors();
  drawGrid();
  if (start)
    p.apply(matList);
  //showInfo();
}

void showInfo() {
  if (showInfo && index < matList.size())
    showInfo(matList.get(index));
  if (runRSeries)
    showR_info();
}

void drawGrid() {
  p.set(u, v);
  p.grid();
  origin();
}
