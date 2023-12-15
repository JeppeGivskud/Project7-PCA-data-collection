class ScreenHandler { //<>// //<>// //<>//
  ArrayList<Screen> Screens = new ArrayList<Screen>();
  int CurrentScreen=0;
  SaveWide SaveWide;
  SaveLong SaveLong;
  boolean exitnow=false;

  InBetweenScreen InBetweenScreen = new InBetweenScreen("Du skal have en ny øl \n \n Tryk på næste når du har fået en ny øl");

  ScreenHandler(StringList Beers, int questionsPerScreen) {
    for (int i=0; i<Beers.size(); i++) {
      Screens.add(new Screen(Beers.get(i), questionsPerScreen));
    }
  }


  /*
Der er problemer med at gemme dataen og der er problemer med flowet af programmet. Hvis du går igennem fra toppen burde det vise sig selv
   */
  void Draw() {
    if (InBetweenScreen.Done==false) {
      InBetweenScreen.NextButton.CanBePressed=true;
      InBetweenScreen.Draw();
      return;
    }
    if (CurrentScreen<Screens.size()) {
      if (Screens.get(CurrentScreen).NextScreenRequest()) {
        InBetweenScreen.Done=false;
        println(Screens.get(CurrentScreen).Name+" is done");
        CurrentScreen++;
        return;
      }

      if (!Screens.get(CurrentScreen).NextScreenRequest()) {
        Screens.get(CurrentScreen).Draw();
        CurrentBeerText();
        return;
      }
    } else if (!exitnow&&InBetweenScreen.Done==true) {
      InBetweenScreen.Done=false;
      InBetweenScreen.Message="Der er ikke flere øl \n Tak fordi du ville være med";
      exitnow=true;
      return;
    }
    println("Saving:");
    String ID = "ID_"+millis()+"_"+second()+"_"+minute()+"_"+"_"+hour()+"_"+day()+"_"+month();
    this.SaveLong = new SaveLong(ID, Screens);
    this.SaveWide = new SaveWide(ID, Screens);

    exit();
  }

  void CurrentBeerText() {
    fill(0, 0, 0);
    textSize(20);
    textAlign(CENTER, CENTER);
    int BeerNumber = CurrentScreen+1;
    int ScreenNumber = Screens.get(CurrentScreen).current_questions+1;
    text("Øl "+BeerNumber+"/"+Screens.size(), width/2, height-55);
    text("Side "+ScreenNumber+"/"+Screens.get(CurrentScreen).SliderGroup.size(), width/2, height-80);
    //rect(0, height-20, (width/Screens.size())/2+(CurrentScreen)*width/Screens.size(), 20);
  }

  void MouseReleased() {
    if (InBetweenScreen.Done==false) { //If the inbetween is drawing we check and change the nextbutton state
      InBetweenScreen.MouseReleased();
      return;
    }
    try { //This is necessary because spamming the mouse can call the mouseReleased() function before the program has time to shut down.
      Screens.get(CurrentScreen).MouseReleased();
      return;
    }
    catch (Exception e) {
      print(e);
    }
  }
}
