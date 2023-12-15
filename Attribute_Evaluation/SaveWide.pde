class SaveWide {
  Table newTable;
  Table oldTable;
  ArrayList<Screen> Screens;
  String ID;

  SaveWide(String ID, ArrayList<Screen> Screens) {
    this.ID=ID;
    this.Screens=Screens;
    SaveIndividual();
    AppendOldTable("data/MegaTables/MEGATABLE_WIDE.csv");
  }

  void SaveIndividual() {
    //Create table
    this.newTable= new Table();
    String Beer;
    String Attribute;
    int Answer;

    StringList Attributes = new StringList();
    Attributes.append(loadStrings("Attributes.csv"));

    this.newTable.addColumn("ID");
    this.newTable.addColumn("Beer");
    for (String AttributeinCSV : Attributes) {
      this.newTable.addColumn(AttributeinCSV);
      println(AttributeinCSV);
    }

    //For each slider, find the cell with the coresponding attribute and set that value to slider value
    Slider Slider;

    println("Screens"+Screens.size());
    for (int o=0; o<Screens.size(); o++) {
      //Screen = Screens.get(o);
      Beer = Screens.get(o).Name;
      println("Slidergroups"+Screens.get(o).SliderGroup.size());

      TableRow row = this.newTable.addRow(); //Byg en ny row som man kan lægge nogle værdier ind i
      row.setString("ID", this.ID);
      row.setString("Beer", Beer);

      for (int i=0; i < Screens.get(o).SliderGroup.size(); i++) { //loop ned til skærm
        //GroupOfSliders = Screens.get(o).SliderGroup.get(i);
        println("Sliders"+Screens.get(o).SliderGroup.get(i).Sliders.size());

        for (int j=0; j<Screens.get(o).SliderGroup.get(i).Sliders.size(); j++) { //loop ned til individuel slider
          Slider = Screens.get(o).SliderGroup.get(i).Sliders.get(j);

          Attribute = Slider.Question;
          Answer=Slider.Value;

          row.setInt(Attribute, Answer); //Vi kan sætte en bestemt string til at have en bestemt værdi
        }
      }
    }
    saveTable(this.newTable, "data/Wide/"+this.ID+"Wide"+".csv");
  }
  void AppendOldTable(String path) {
    this.oldTable = loadTable(path, "header");

    StringList Attributes = new StringList();
    Attributes.append(loadStrings("Attributes.csv"));

    try {
      saveTable(this.oldTable, path);
    }

    catch(Exception e) {
      this.oldTable= new Table();
      this.oldTable.addColumn("ID");
      this.oldTable.addColumn("Beer");
      for (String Attribute : Attributes) {
        this.oldTable.addColumn(Attribute);
      }
      saveTable(this.oldTable, path);
    }
    //For each row in newTable
    for (int row=0; row<newTable.getRowCount(); row++) {
      TableRow newRow = oldTable.addRow();
      
      String Beer=newTable.getString(row, "Beer");
      newRow.setString("ID", this.ID);
      newRow.setString("Beer", Beer);

      //For each column in newtable except the first two because ID and Beer
      for (int column=2; column<oldTable.getColumnCount(); column++) {
        int value=newTable.getInt(row, column);
        newRow.setInt(column, value)  ;
      }
    }

    saveTable(this.oldTable, path);
  }
}
