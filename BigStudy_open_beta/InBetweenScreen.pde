class InBetweenScreen {
  boolean Done= true;
  String Message;
  NavigationButton NextButton;


  InBetweenScreen(String Message) {
    this.Message=Message;
    NextButton = new NavigationButton("Næste", 5*width/8, height-75, 2*width/8, 50);
  }

  //Nextbutton is made as canbepressed. When it is pressed the inbetweenscreen's done is true and the nextbutton is the opposite of true

  void Draw() {
    textAlign(CENTER, CENTER);
    textSize(35);
    text(Message, width/2, height/2);
    textSize(25);
    NextButton.Draw();
  }

  void MouseReleased() {

    if (NextButton.IsMouseOverButton()) {
      this.Done=true;
      NextButton.CanBePressed=false;
      println("NextbuttonPressed");
    }
  }
}
