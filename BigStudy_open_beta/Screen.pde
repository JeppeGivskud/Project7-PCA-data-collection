class Screen {
  //Table questions; This should be deleted
  String[] Questions;
  int groupsize=0;
  ArrayList<Sliders> SliderGroup = new ArrayList<Sliders>();
  ArrayList<String[]> Questionons = new ArrayList<String[]>();
  int current_questions=0;

  String Name;

  //Åndsvag løsning:
  int BackButtonX   =width/8;
  int BackButtonY   =height-75;
  int NextButtonX   =5*width/8;
  int NextButtonY   =height-75;
  int ButtonWidth   =2*width/8;
  int ButtonHeight  =50;

  Screen(String Name, int questionsPerScreen) {
    this.Name=Name;
    LoadQuestions();
    RandomizeQuestions();
    Sepperate_into_groups(questionsPerScreen);
    println("Questions: "+Questions.length);
    println(Questionons.size()+" Groups with size: "+groupsize);
    MakeSliderGroups(Questionons);
  }

  void Draw() {
    SliderGroup.get(this.current_questions).Draw();
    DrawButton();
  }

  boolean NextScreenRequest() {
    if (this.current_questions>Questionons.size()-1) {
      //When there are no more questions and the next button is clicked
      //this will return true so the next screen can be showed
      return true;
    }
    return false;
  }

  void IsMouseOverButtons() {

    if (mouseX  > this.BackButtonX  &&  mouseX  <  this.BackButtonX+ButtonWidth
      && mouseY  >  this.BackButtonY  &&  mouseY  <  this.BackButtonY+ButtonHeight) {
      if (this.current_questions>0) {
        this.current_questions--;
      }
    }
    if (mouseX  > this.NextButtonX  &&  mouseX  <  this.NextButtonX+this.ButtonWidth
      && mouseY  >  this.NextButtonY  &&  mouseY  <  this.NextButtonY+this.ButtonHeight) {
      if (this.current_questions<Questionons.size()) {
        if (/*true || */SliderGroup.get(this.current_questions).CheckIfAllAreAssesed()) {
          this.current_questions++;
        }
      }
    }
  }

  void DrawButton() {
    fill(255);
    strokeWeight(3);
    stroke(0);
    Button("Back", BackButtonX, BackButtonY, ButtonWidth, ButtonHeight);

    if (!SliderGroup.get(this.current_questions).CheckIfAllAreAssesed()) {
      stroke(150);
      fill(200);
    } else {
      stroke(0);
    }
    Button("Next", NextButtonX, NextButtonY, ButtonWidth, ButtonHeight);
  }

  void Button(String string, int StartX, int StartY, int Width, int Heigth) {

    rect(StartX, StartY, Width, Heigth, 28);
    fill(0);
    textAlign(CENTER, CENTER);
    text(string, StartX, StartY-3, Width, Heigth);  // Text wraps within text box
    fill(255);
  }

  void MakeSliderGroups(ArrayList<String[]> Questiongroups) {
    for (String[] questions : Questiongroups) {
      //Tilføj en ny slidergroup med questions
      SliderGroup.add(new Sliders(questions));
    }
  }

  void LoadQuestions() {
    this.Questions = loadStrings("Questions.csv");
  }

  void RandomizeQuestions() {
    StringList Randomized = new StringList();
    Randomized.append(this.Questions);
    Randomized.shuffle();

    int i=0;
    for (String Question : Randomized) {
      this.Questions[i]=Question;
      i++;
    }
  }
  void Sepperate_into_groups(int groupsize) {
    this.groupsize=groupsize;
    //Indel groft i size men undlad at indele den sidste del fordi så er den out of bounds
    int counter=0;

    try {
      for (int i=0; i<Questions.length; i+=groupsize) {
        counter=i;
        String[] TempStringArray = subset(Questions, i, groupsize);
        Questionons.add(TempStringArray);
        //println(i);
        //println(Questions.length-groupsize);
      }
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
          String[] TempStringArray = subset(Questions, counter, groupsize-i);
          Questionons.add(TempStringArray);
          println("SUCCES");
          success=true;
        }
        catch (Exception e) {
          println("Failed at combining with "+newcounter+" new values");
        }
      }
    }
  }
}
