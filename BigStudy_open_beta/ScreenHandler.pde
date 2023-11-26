class ScreenHandler {
  ArrayList<Screen> Screens = new ArrayList<Screen>();
  int CurrentScreen=0;

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
    exit();

    //SaveAllData();
  }

  void SaveAllData() {
    Table table= new Table();

    String ID = "ID:"+millis() +"_" + second()+"_"  +hour()+"_"  +day() +"_" +month()  ;
    String Beer;
    String Attribute;
    int Answer;

    table.addColumn("ID");
    table.addColumn("Beer");
    table.addColumn("Attribute");
    table.addColumn("Answer");

    Screen Screen;
    Sliders GroupOfSliders;
    Slider Slider;

    println("Screens"+Screens.size());
    for (int o=0; o<Screens.size(); o++) {
      //Screen = Screens.get(o);
      Beer = Screens.get(o).Name;
      println("Slidergroups"+Screens.get(o).SliderGroup.size());

      for (int i=0; i < Screens.get(o).SliderGroup.size(); i++) {
        //GroupOfSliders = Screens.get(o).SliderGroup.get(i);
        println("Sliders"+Screens.get(o).SliderGroup.get(i).Sliders.size());

        for (int j=0; j<Screens.get(o).SliderGroup.get(i).Sliders.size(); j++) {
          Slider = Screens.get(o).SliderGroup.get(i).Sliders.get(j);

          Attribute = Slider.Question;
          Answer=Slider.Value;

          TableRow row = table.addRow();
          row.setString("ID", ID);
          row.setString("Beer", Beer);
          row.setString("Attribute", Attribute);
          row.setInt("Answer", Answer);
          println(ID+"ID-"+Beer+"Beer-"+Attribute+"Attribute-"+Answer+"Answer-");
        }
      }
    }
    saveTable(table, "data/"+ID+".csv");
    AppendMegatable(table);
  }


  void AppendMegatable(Table Newtable) {

    Table table = loadTable("MEGATABLE.csv", "header");
    try {
      saveTable(table, "MEGATABLE.csv");
    }
    catch(Exception e) {
      table= new Table();
      table.addColumn("ID");
      table.addColumn("Beer");
      table.addColumn("Attribute");
      table.addColumn("Answer");
      saveTable(table, "MEGATABLE.csv");
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
    saveTable(table, "MEGATABLE.csv");
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

/*
    for (int ost=0; ost<Screens.size(); ost++) {
 Screen = Screens.get(ost);
 Beer = Screen.Name;
 println("Slidergroups"+Screen.SliderGroup.size());
 
 for (int i=0; i < Screen.SliderGroup.size(); i++) {
 GroupOfSliders = Screen.SliderGroup.get(i);
 println("Sliders"+GroupOfSliders.Sliders.size());
 
 for (int j=0; i<GroupOfSliders.Sliders.size(); i++) {
 Slider = GroupOfSliders.Sliders.get(j);
 
 Attribute = Slider.Question;
 Answer=Slider.Value;
 
 TableRow row = table.addRow();
 row.setString("id", ID);
 row.setString("Beer", Beer);
 row.setString("Attribute", Attribute);
 row.setInt("Answer", Answer);
 println(ID+"ID-"+Beer+"Beer-"+Attribute+"Attribute-"+Answer+"Answer-");
 }
 }
 }
 */
