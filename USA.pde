
int[][] USA_coordinates;

void USA() {
  String[] lines = loadStrings("/Users/satviksrinivas/Documents/HSS_College_Heat_Map/USA.txt");
  USA_coordinates = new int[lines.length][2];
  int index = -1;
  for (int i = 0; i < lines.length; i++) {
    index = lines[i].indexOf(",");
    USA_coordinates[i][0] = (int) (USA_displayFactor * Double.parseDouble(lines[i].substring(0, index))) + USA_xOffset;
    USA_coordinates[i][1] = (int) (USA_displayFactor * Double.parseDouble(lines[i].substring(index + 1))) + USA_yOffset;
  }
}

int USA_xOffset = -900, USA_yOffset = -135;
float USA_displayFactor = 0.75;

void displayUSA() {
  for (int i = 0; i < USA_coordinates.length; i++)
    point(USA_coordinates[i][0], 0, USA_coordinates[i][1], orange);
}
