
float getX (float x) {
  return x + displayWidth/2.0;
}

float getY (float y) {
  return -y + displayHeight/2.0;
}

float mouseX() {
  return mouseX - displayWidth/2.0;
}

float mouseY() {
  return displayHeight/2.0 - mouseY;
}

boolean showMouseCoordinates;
void displayMouseCoordinates() {
  if (!showMouseCoordinates)
    return;
  textSize(45);
  fill(white);
  text("("+mouseX()+", "+mouseY()+")", mouseX, mouseY);
}

float plotRadius = 1.75;
void plot (float x, float y) {
  noStroke();
  fill (255);
  circle(getX(x), getY(y), plotRadius);
}

void plot (Vector v) {
  plot (v.x, v.y);
}

void plot (Vector v, color c) {
  plot (v.x, v.y, c);
}

void plot (float x, float y, color c) {
  noStroke();
  fill (c);
  circle(getX(x), getY(y), pointSize);
}

void origin() {
  plot(0, 0, color(255, 255, 0));
}

class Pair {
  float one, two;
  Pair() {
  }
  Pair (float one, float two) {
    this.one = one;
    this.two = two;
  }
}
