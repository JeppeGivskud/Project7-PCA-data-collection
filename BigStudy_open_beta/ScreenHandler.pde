class ScreenHandler {
  ArrayList<Screen> Screens = new ArrayList<Screen>();
  int CurrentScreen=0;
  SaveWide SaveWide;
  SaveLong SaveLong;

  ScreenHandler(StringList Beers, int questionsPerScreen) {
    for (int i=0; i<Beers.size(); i++) {
      Screens.add(new Screen(Beers.get(i), questionsPerScreen));
    }
  }


  /*
Der er problemer med at gemme dataen og der er problemer med flowet af programmet. Hvis du går igennem fra toppen burde det vise sig selv
   */
  void Draw() {
    CurrentBeerText();

    if (CurrentScreen<Screens.size()) {
      if (!Screens.get(CurrentScreen).NextScreenRequest()) {
        Screens.get(CurrentScreen).Draw();
        return;
      } else {
        println(Screens.get(CurrentScreen).Name+" is done");
        CurrentScreen++;
        return;
      }
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
    int value = CurrentScreen+1;
    text("Beer "+value, width/2, height-55);
    //rect(0, height-20, (width/Screens.size())/2+(CurrentScreen)*width/Screens.size(), 20);
  }

  void MouseReleased() {
    try { //This is necessary because spamming the mouse can call the mouseReleased() function before the program has time to shut down.
      Screens.get(CurrentScreen).MouseReleased();
    }
    catch (Exception e) {
      print(e);
    }
  }
}
