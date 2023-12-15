class WelcomeScreen {
  boolean Done= false;
  String WelcomeMessage;
  String SliderQuestion;
  NavigationButton NextButton = new NavigationButton("Næste", 5*width/8, height-75, 2*width/8, 50);

  Slider Slider;

  WelcomeScreen(String WelcomeMessage, String SliderQuestion) {
    this.WelcomeMessage=WelcomeMessage;
    this.SliderQuestion=SliderQuestion;
    this.Slider = new Slider(40, height/2, width-300, this.SliderQuestion);
  }

  void Draw() {
    textAlign(CENTER, CENTER);
    textSize(25);
    text(WelcomeMessage, 100, -width/4, width-200, height);
    textSize(25);
    HandleButtons();

    if (this.Slider.valueSelected) {
      NextButton.CanBePressed(true);
      text("Du kan godt ændre dit svar \n Tryk på *næste* når du er klar til at starte forsøget", 0, width/4, width, height);
    }
    Slider.Draw();
  }
  void HandleButtons() {
    NextButton.Draw();

    NextButton.CanBePressed(false);
  }

  void MouseReleased() {
    if (NextButton.IsMouseOverButton()) {
      Done=true;
    }
    this.Slider.MouseReleased();
  }

  boolean Done() {
    return Done;
  }
}
