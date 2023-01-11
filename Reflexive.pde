
String rSeriesName = "rSeries";
AnimationList rSeries = new AnimationList();
ArrayList<String> rInfo = new ArrayList<String>();

void reflexiveSeries() {
  rSeries.name = rSeriesName;
  Pair ad = new Pair(), bc = new Pair();
  Pair[] zeroes = {new Pair(0, 0), new Pair(0, 1), new Pair (0, -1), new Pair(1, 0), new Pair (-1, 0)};
  // positiveOne
  ad = zeroes[0];
  for (int i = 1; i >= -1; i-=2) {
    bc = new Pair (i, i);
    rSeries.add(new Matrix (ad.one, bc.one, bc.two, ad.two));
  } 
  // negativeOne
  for (int i = 1; i >= -1; i-=2) {
    ad = new Pair (i, -i);
    for (int k = 0; k < zeroes.length; k++) {
      bc = zeroes[k];     
      rSeries.add(new Matrix (ad.one, bc.one, bc.two, ad.two));
    }
  }
  rSeries.toString();
}

void showInfo(Matrix m) {
  textSize(50);
  text(m.toString(), 0.025 * displayWidth, 0.1 * displayHeight);
  text(numberInput, 0.025 * displayWidth, 0.95 * displayHeight);
}

void showR_info() {
  textSize(50);
  text(rInfo.get(number), 0.025 * displayWidth, 0.1 * displayHeight);
  text(numberInput, 0.025 * displayWidth, 0.95 * displayHeight);
}
