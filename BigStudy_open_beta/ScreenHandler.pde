class ScreenHandler {
  ArrayList<Screen> Screens = new ArrayList<Screen>();
  int CurrentScreen=0;
  SaveWide SaveWide;

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
    SaveAllData();
    
    this.SaveWide = new SaveWide(Screens);

    exit();
  }

  void SaveAllData() {
    Table table= new Table();

    String ID = "ID_"+millis() +"_" + second()+"_"  +hour()+"_"  +day() +"_" +month()  ;
    String Beer;
    String Attribute;
    int Answer;

    table.addColumn("ID");
    table.addColumn("Beer");
    table.addColumn("Attribute");
    table.addColumn("Answer");

    Slider Slider;

    println("Beers: "+Screens.size());
    for (int o=0; o<Screens.size(); o++) {
      //Screen = Screens.get(o);
      Beer = Screens.get(o).Name;
      //println("Slidergroups"+Screens.get(o).SliderGroup.size());

      for (int i=0; i < Screens.get(o).SliderGroup.size(); i++) {
        //GroupOfSliders = Screens.get(o).SliderGroup.get(i);
        // println("Sliders"+Screens.get(o).SliderGroup.get(i).Sliders.size());

        for (int j=0; j<Screens.get(o).SliderGroup.get(i).Sliders.size(); j++) {
          Slider = Screens.get(o).SliderGroup.get(i).Sliders.get(j);

          Attribute = Slider.Question;
          Answer=Slider.Value;

          TableRow row = table.addRow();
          row.setString("ID", ID);
          row.setString("Beer", Beer);
          row.setString("Attribute", Attribute);
          row.setInt("Answer", Answer);
          //println(ID+"ID-"+Beer+"Beer-"+Attribute+"Attribute-"+Answer+"Answer-");
        }
      }
    }
    saveTable(table, "data/Long/"+ID+".csv");
    AppendMegatable(table,"data/MegaTables/MEGATABLE_LONG.csv");
  }


  void AppendMegatable(Table Newtable, String Path) {

    Table table = loadTable(Path, "header");
    try {
      saveTable(table, Path);
    }
    catch(Exception e) {
      table= new Table();
      table.addColumn("ID");
      table.addColumn("Beer");
      table.addColumn("Attribute");
      table.addColumn("Answer");
      saveTable(table, Path);
    }

    for (TableRow row : Newtable.rows()) {
      //Load all values from the row
      String ID = row.getString("ID");
      String Beer = row.getString("Beer");
      String Attribute=row.getString("Attribute");
      int Answer = row.getInt("Answer");

      //Append the original table with new row and values

      TableRow newRow = table.addRow();
      newRow.setString("ID", ID);
      newRow.setString("Beer", Beer);
      newRow.setString("Attribute", Attribute);
      newRow.setInt("Answer", Answer);
    }
    saveTable(table, Path);
  }

  void CurrentBeerText() {
    fill(0, 0, 0);
    textSize(20);
    textAlign(CENTER, CENTER);
    int value = CurrentScreen+1;
    text("Beer "+value, width/2, height-55);
    //rect(0, height-20, (width/Screens.size())/2+(CurrentScreen)*width/Screens.size(), 20);
  }

  void CheckMousePosition() {
    try { //This is necessary because spamming the mouse can call the mouseReleased() function before the program has time to shut down.
      Screens.get(CurrentScreen).IsMouseOverButtons();
    }
    catch (Exception e) {
      print(e);
    }
  }
}
