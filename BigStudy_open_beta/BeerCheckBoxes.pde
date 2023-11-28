class BeerCheckBoxes {
  String[] AllBeers ;
  StringList ChoosenBeers = new StringList();

  boolean IsBeersChosen=false;
  ArrayList<BeerCheckBox> AllBoxes = new ArrayList<BeerCheckBox>();

  BeerCheckBoxes() {
    LoadBeers("Beers.csv");
    MakeBoxes();
  }

  void Draw() {
    if (AllBoxes.get(10).getValue()) {
      IsBeersChosen=true;
      println("ALL BOXES ARE CLICKED");
      ChoosenBeers.remove(ChoosenBeers.size()-1);
      println("Continue removed");
    }

    /*//TESTCASE
    for (BeerCheckBox BeerCheckBox : AllBoxes) {
      BeerCheckBox.IsChecked=true;
    }
    IsBeersChosen=true;
    for (int i=0; i<AllBoxes.size(); i++) {
      ChoosenBeers.append(AllBoxes.get(i).Name);
      println("Appended: "+AllBoxes.get(i).Name);
    }
    //END testcase */

    for (int i=0; i<AllBoxes.size(); i++) {
      AllBoxes.get(i).Draw();
      fill(0);
      textSize(80);
      text("Click on the beers you want and press continue", 200, 0, width-200, height);
    }
  }

  void WhichBoxesAreChecked() {
    for (int i=0; i<AllBoxes.size(); i++) {
      if (!AllBoxes.get(i).getValue()) { //Hvis en box ikke allerede er grøn bliver den checket
        AllBoxes.get(i).IsMouseOverButton();
        if (AllBoxes.get(i).IsChecked) {
          ChoosenBeers.append(AllBoxes.get(i).Name);
          println("Appended: "+AllBoxes.get(i).Name);
        }
      }
    }
  }

  /* void RegisterChoosenBoxes() {
   AllBoxes.get(AllBoxes.size()-1).IsChecked=false;
   for (int i=0; i<AllBoxes.size(); i++) {
   if (AllBoxes.get(i).getValue()) {
   ChoosenBeers.append(AllBoxes.get(i).Name);
   }
   }
   }*/

  void MakeBoxes() {
    for (int i=0; i<AllBeers.length; i++) {
      //Tilføj en ny slidergroup med questions
      AllBoxes.add(new BeerCheckBox(AllBeers[i], 20, 20+60*i, 150, 50));
    }
    AllBoxes.add(new BeerCheckBox("Continue", 20, height-100, 150, 50));

    println("CheckBoxes: "+AllBoxes.size());
  }
  //  BeerCheckBox(String Name, int StartX, int StartY, int Width, int Height) {


  void LoadBeers(String path) {
    this.AllBeers = loadStrings(path);
  }
}
