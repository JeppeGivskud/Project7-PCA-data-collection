class Slider {
  int StartX;
  int StartY;
  String Question;
  int Value;
  StringList Markers;
  int Length;
  boolean valueSelected=false;
  float[] Placements;

  Slider(int StartX, int StartY, int Length, String Question) {
    this.StartX=StartX;
    this.StartY=StartY;
    this.Question=Question;
    this.Length=Length;
    Markers = new StringList();
    Markers();
    CreateXPositions();

    /*//TESTCASE;
    this.valueSelected=true;
    this.Value=round(random(0, this.Markers.size()-1));*/
  }
  

  
  
  void Draw() {
    strokeWeight(2);
    stroke(200);
    line(StartX-50, StartY+30, StartX+Length+50, StartY+30);

    DrawMarkers();
    textSize(20);
    fill(0);
    text(this.Question, this.StartX+this.Length/2, this.StartY-40);

    CheckMouse();
    DrawCircle();
  }

  void Markers() {
    this.Markers.append("Slet ikke");
    this.Markers.append("Meget lidt");
    this.Markers.append("Lidt");
    this.Markers.append("Moderat");
    this.Markers.append("Meget");
    this.Markers.append("Rigtig meget");
    this.Markers.append("Ekstremt");
  }

  void CreateXPositions() {
    float Difference=Length/(this.Markers.size()-1);
    float Shifttoright=(width-Length)/2;
    this.Placements = new float[this.Markers.size()];
    for (int i = 0; i < this.Markers.size(); i++) {
      this.Placements[i]=Difference*i+Shifttoright;
    }
    this.StartX=int(this.Placements[0]);
  }

  void DrawMarkers() { //for each string in Markers
    textSize(15);
    for (int i = 0; i < this.Markers.size(); i++) {

      fill(0);
      textAlign(CENTER);
      text(this.Markers.get(i), this.Placements[i], StartY-20);

      strokeWeight(1);
      fill(255);
      circle(this.Placements[i], this.StartY, 25);
    }
  }


  void CheckMouse() {
    if (mousePressed == true) { //Registers a mousepress and logs the value
      int extraline=30;
      if (mouseX  > StartX-extraline  &&  mouseX  <  StartX+Length+extraline
        && mouseY  >  StartY-extraline  &&  mouseY  <  StartY+extraline) {
        this.valueSelected=true;
        //Converts the value from pixel to likert scale
        this.Value=round(map(mouseX, StartX, StartX+Length, 0, this.Markers.size()-1));
      }
    }
  }

  void DrawCircle() {
    if (valueSelected) { //If a value is selected convert that value into pixels
      noStroke();
      fill (80);
      circle(this.Placements[this.Value], this.StartY, 20);
    }
  }
}

/*
  void DrawMarkers() { //for each string in Markers
 textSize(15);
 for (int i = 0; i < this.Markers.size(); i++) {
 fill(0);
 textAlign(CENTER);
 float Difference=Length/(this.Markers.size()-1);
 text(this.Markers.get(i), StartX+i*Difference, StartY-15);
 line(StartX+i*Difference, StartY+10, StartX+i*Difference, StartY-10);
 }
 }*/
