BeerCheckBoxes BeerCheckBoxes;
ScreenHandler ScreenHandler;
boolean ScreensCreated=false;

void setup() {
  size(1000, 840);
  BeerCheckBoxes = new BeerCheckBoxes();
  frameRate(10);
}

void draw() {
  background(230);
  //Screen.Draw();
  //BeerCheckBox.Draw();
  while (!BeerCheckBoxes.IsBeersChosen) {
    BeerCheckBoxes.Draw();
    return;
  }
  
  // Sends the choosen beers to screenhandler to create a set of screens (one for each beer)
  if (!ScreensCreated) {
    ScreenHandler = new ScreenHandler(BeerCheckBoxes.ChoosenBeers  ,  6);
    ScreensCreated=true;
    printArray(BeerCheckBoxes.ChoosenBeers);
  }
  
  ScreenHandler.Draw();

}

void mouseReleased() {
  if (!BeerCheckBoxes.IsBeersChosen) {
    BeerCheckBoxes.WhichBoxesAreChecked();
    return;
  }
  ScreenHandler.CheckMousePosition();
}
