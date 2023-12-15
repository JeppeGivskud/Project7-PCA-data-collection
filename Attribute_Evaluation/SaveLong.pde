class SaveLong {
  Table newTable;
  Table oldTable;
  ArrayList<Screen> Screens;
  String ID;

  SaveLong(String ID, ArrayList<Screen> Screens) {
    this.ID=ID;
    this.Screens=Screens;
    SaveIndividual();
    AppendOldTable("data/MegaTables/MEGATABLE_LONG.csv");
  }


  void SaveIndividual() {
    this.newTable = new Table();

    this.newTable.addColumn("ID");
    this.newTable.addColumn("Beer");
    this.newTable.addColumn("Attribute");
    this.newTable.addColumn("Answer");
    this.newTable.addColumn("Beer_order");
    this.newTable.addColumn("Attribute_order");
    this.newTable.addColumn("Attribute_order_absolute");

    Slider Slider;

    println("Beers: "+Screens.size());
    for (int o=0; o<Screens.size(); o++) { //For alle screens
      String Beer = Screens.get(o).Name;

      for (int i=0; i < Screens.get(o).SliderGroup.size(); i++) {

        for (int j=0; j<Screens.get(o).SliderGroup.get(i).Sliders.size(); j++) {

          Slider = Screens.get(o).SliderGroup.get(i).Sliders.get(j);

          String Attribute = Slider.Question;
          int Answer=Slider.Value;

          int Beer_order=o+1;

          //The order is defined as the the current attribute group * that groups size + the current slider j
          int Attribute_order=i*Screens.get(o).SliderGroup.get(i).Amount+j+1;

          //The absolute order just adds attribute length for each new beer (o)
          int Attribute_order_absolute=Attribute_order+o*Screens.get(o).Attributes.length;

          TableRow row = this.newTable.addRow();
          row.setString("ID", this.ID);
          row.setString("Beer", Beer);
          row.setString("Attribute", Attribute);
          row.setInt("Answer", Answer);
          row.setInt("Beer_order", Beer_order);
          row.setInt("Attribute_order", Attribute_order);
          row.setInt("Attribute_order_absolute", Attribute_order_absolute);
          //println(ID+"ID-"+Beer+"Beer-"+Attribute+"Attribute-"+Answer+"Answer-");
        }
      }
    }
    saveTable(this.newTable, "data/Long/"+this.ID+".csv");
  }


  void AppendOldTable(String Path) {

    this.oldTable = loadTable(Path, "header");
    try {
      saveTable(this.oldTable, Path);
    }
    catch(Exception e) {
      this.oldTable= new Table();
      this.oldTable.addColumn("ID");
      this.oldTable.addColumn("Beer");
      this.oldTable.addColumn("Attribute");
      this.oldTable.addColumn("Answer");
      this.oldTable.addColumn("Beer_order");
      this.oldTable.addColumn("Attribute_order");
      this.oldTable.addColumn("Attribute_order_absolute");

      saveTable(this.oldTable, Path);
    }

    for (TableRow row : this.newTable.rows()) {
      //Load all values from the row
      String Beer = row.getString("Beer");
      String Attribute=row.getString("Attribute");
      int Answer = row.getInt("Answer");
      int Beer_order = row.getInt("Beer_order");
      int Attribute_order = row.getInt("Attribute_order");
      int Attribute_order_absolute = row.getInt("Attribute_order_absolute");

      //Append the original table with new row and values
      TableRow newRow = this.oldTable.addRow();
      newRow.setString("ID", this.ID);
      newRow.setString("Beer", Beer);
      newRow.setString("Attribute", Attribute);
      newRow.setInt("Answer", Answer);
      newRow.setInt("Beer_order", Beer_order);
      newRow.setInt("Attribute_order", Attribute_order);
      newRow.setInt("Attribute_order_absolute", Attribute_order_absolute);
    }
    saveTable(this.oldTable, Path);
  }
}
