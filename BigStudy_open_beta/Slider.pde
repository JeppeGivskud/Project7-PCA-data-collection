class Slider {
  int StartX;
  int StartY;
  String Question;
  int Value;
  StringList Markers;
  int Length;
  boolean valueSelected=false;

  Slider(int StartX, int StartY, int Length, String Question) {
    this.StartX=StartX;
    this.StartY=StartY;
    this.Question=Question;
    this.Length=Length;
    Markers = new StringList();
    Markers();
  }

  void Draw() {
    strokeWeight(5);
    stroke(0);
    line(StartX, StartY, StartX+Length, StartY);

    DrawMarkers();
    CheckMouse();
    DrawCircle();
    textSize(20);
    text(this.Question, this.StartX+this.Length/2, this.StartY-40);
  }

  void Markers() {
    this.Markers.append("Slet ikke");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("I nogen grad");
    this.Markers.append("Meget");
  }

  void DrawMarkers() { //for each string in Markers
    textSize(15);
    for (int i = 0; i < this.Markers.size(); i++) {
      fill(0);
      textAlign(CENTER);
      float Difference=Length/(this.Markers.size()-1);
      text(this.Markers.get(i), StartX+i*Difference, StartY-15);
      line(StartX+i*Difference, StartY+10, StartX+i*Difference, StartY-10);
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
      strokeWeight(5);
      fill (0);
      float drawnvalue=map(this.Value, 0, this.Markers.size()-1, 0, Length);
      circle(StartX+drawnvalue, this.StartY, 15);
    }
  }
}
