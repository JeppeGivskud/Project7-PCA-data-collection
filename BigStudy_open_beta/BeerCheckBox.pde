class BeerCheckBox {
  int StartX;
  int StartY;
  int Width;
  int Height;
  String Name;
  boolean IsChecked=false;

  BeerCheckBox(String Name, int StartX, int StartY, int Width, int Height) {
    this.StartX=StartX;
    this.StartY=StartY;
    this.Width=Width;
    this.Height=Height;
    this.Name=Name;


  }

  void Draw() {
    if (IsChecked) stroke(0, 255, 0);
    else stroke(255, 0, 0);
    fill(255);
    rect(StartX, StartY, Width, Height, 28);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(this.Name, this.StartX, this.StartY-3, this.Width, this.Height);  // Text wraps within text box}
  }

  void IsMouseOverButton() {
    if (mouseX  > this.StartX  &&  mouseX  <  this.StartX+Width
      && mouseY  >  this.StartY  &&  mouseY  <  this.StartY+Height) {
      if (this.IsChecked==true) {
        this.IsChecked=false;
      } else if (this.IsChecked==false) {
        this.IsChecked=true;
      }
    }
  }


  boolean getValue() {
    return this.IsChecked;
  }
}
