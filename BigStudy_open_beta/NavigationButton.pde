class NavigationButton {
  int Xpos, Ypos, Width, Height;
  String Text;
  boolean CanBePressed=false;

  NavigationButton(String Text, int Xpos, int Ypos, int Width, int Height) {
    this.Text=Text;
    this.Xpos=Xpos;
    this.Ypos=Ypos;
    this.Width=Width;
    this.Height=Height;
  }

  void CanBePressed(boolean value) {
    this.CanBePressed=value;
  }

  void Draw() {
    if (CanBePressed) {
      fill(255);
      stroke(0);
    } else {
      stroke(150);
      fill(200);
    }
    rect(Xpos, Ypos, Width, Height, 28);

    fill(0);
    textAlign(CENTER, CENTER);
    text(this.Text, this.Xpos, this.Ypos-3, Width, Height);  // Text wraps within text box
  }

  boolean IsMouseOverButton() {
    if (mouseX  > this.Xpos  &&  mouseX  <  this.Xpos+Width
      && mouseY  >  this.Ypos  &&  mouseY  <  this.Ypos+Height) {
      return true;
    }
    return false;
  }
}
