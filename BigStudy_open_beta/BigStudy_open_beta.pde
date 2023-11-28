BeerCheckBoxes BeerCheckBoxes;
WelcomeScreen WelcomeScreen;
ScreenHandler ScreenHandler;
boolean ScreensCreated=false;

void setup() {
  size(1000, 840);
  BeerCheckBoxes = new BeerCheckBoxes();
  WelcomeScreen = new WelcomeScreen("Velkommen til programmet, \n Du kan ikke ødelægge noget så bare slap rolig, \n Prøv at sætte skalaen til 7", "Jeg er klar til at drikke øl");

  frameRate(60);
}

void draw() {
  background(230);
  while (!BeerCheckBoxes.IsBeersChosen) {
    BeerCheckBoxes.Draw();
    return;
  }
  while (!WelcomeScreen.Done()) {
    WelcomeScreen.Draw();
    return;
  }

  // Sends the choosen beers to screenhandler to create a set of screens (one for each beer)
  if (!ScreensCreated) {
    ScreenHandler = new ScreenHandler(BeerCheckBoxes.ChoosenBeers, 6);
    ScreensCreated=true;
    printArray(BeerCheckBoxes.ChoosenBeers);
  }

  //Main draw loop
  ScreenHandler.Draw();
}

void mouseReleased() {
  if (!BeerCheckBoxes.IsBeersChosen) {
    BeerCheckBoxes.WhichBoxesAreChecked();
    return;
  }
  if (!WelcomeScreen.Done) {
    WelcomeScreen.MouseReleased();
    return;
  }
  ScreenHandler.MouseReleased();
}
