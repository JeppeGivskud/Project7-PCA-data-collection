BeerCheckBoxes BeerCheckBoxes;
WelcomeScreen WelcomeScreen;
ScreenHandler ScreenHandler;
boolean ScreensCreated=false;

void setup() {
  size(1000, 840);
  BeerCheckBoxes = new BeerCheckBoxes();
  WelcomeScreen = new WelcomeScreen("Velkommen til forsøget.\n I løbet af forsøget skal du svare på i hvor høj grad en smag er til stede i hver øl du bliver præsenteret. Du får en øl af gangen og skal vurdere 42 spørgsmål per øl, derfor må du gerne spare lidt på øllen, så du ikke løber tør.\n\n Prøv at sætte skalaen til *Ekstremt meget*", "Jeg glæder mig til at drikke øl");

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
