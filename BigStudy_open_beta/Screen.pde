class Screen { //<>//
  //Table questions; This should be deleted
  String[] Attributes;
  int groupsize=0;
  ArrayList<Sliders> SliderGroup = new ArrayList<Sliders>();
  ArrayList<String[]> AttributesList = new ArrayList<String[]>();
  int current_questions=0;

  String Name;

  NavigationButton BackButton = new NavigationButton("Tilbage", width/8, height-75, 2*width/8, 50);
  NavigationButton NextButton = new NavigationButton("Næste", 5*width/8, height-75, 2*width/8, 50);

  Screen(String Name, int questionsPerScreen) {
    this.Name=Name;
    LoadQuestions();
    RandomizeQuestions();
    Sepperate_into_groups(questionsPerScreen);
    println("Questions: "+Attributes.length);
    println(AttributesList.size()+" Groups with size: "+groupsize);
    MakeSliderGroups(AttributesList);
  }

  void Draw() {
    HandleButtons();

    SliderGroup.get(this.current_questions).Draw();

    //TESTCASE
    //current_questions++;
  }

  //Buttons
  void HandleButtons() {
    BackButton.Draw();
    NextButton.Draw();

    if (SliderGroup.get(this.current_questions).CheckIfAllAreAssesed()) {
      NextButton.CanBePressed(true);
    } else NextButton.CanBePressed(false);

    if (current_questions>0) {
      BackButton.CanBePressed(true);
    } else BackButton.CanBePressed(false);
  }

  void MouseReleased() {
    if (BackButton.IsMouseOverButton()) current_questions--;
    if (NextButton.IsMouseOverButton()) current_questions++;
  }

  boolean NextScreenRequest() {
    if (this.current_questions>AttributesList.size()-1) {
      //When there are no more questions and the next button is clicked
      //this will return true so the next screen can be showed
      return true;
    }
    return false;
  }

  //Questions/Attributes
  void LoadQuestions() {
    this.Attributes = loadStrings("Attributes.csv");
  }

  void RandomizeQuestions() {
    StringList Randomized = new StringList();
    Randomized.append(this.Attributes);
    Randomized.shuffle();

    int i=0;
    for (String Question : Randomized) {
      this.Attributes[i]=Question;
      i++;
    }
  }
  void Sepperate_into_groups(int groupsize) {
    this.groupsize=groupsize;
    //Indel groft i size men undlad at indele den sidste del fordi så er den out of bounds
    int counter=0;

    try {
      for (int i=0; i<Attributes.length; i+=groupsize) {
        counter=i;
        String[] TempStringArray = subset(Attributes, i, groupsize);
        AttributesList.add(TempStringArray);
        //println(i);
        //println(Questions.length-groupsize);
      }
      return; //If there are no problems sepperating the groups the rest of the code is not run
    }

    catch (Exception e) {
      println("We failed at "+counter);
    }

    int newcounter=0;
    boolean success=false;
    for (int i = 0; i<groupsize; i++) {
      newcounter=i;
      if (!success) {
        try {
          String[] TempStringArray = subset(Attributes, counter, groupsize-i);
          AttributesList.add(TempStringArray);
          println("SUCCES");
          success=true;
        }
        catch (Exception e) {
          println("Failed at combining with "+newcounter+" new values");
        }
      }
    }
  }

  void MakeSliderGroups(ArrayList<String[]> Questiongroups) {
    for (String[] questions : Questiongroups) {
      //Tilføj en ny slidergroup med questions
      SliderGroup.add(new Sliders(questions));
    }
  }
}
