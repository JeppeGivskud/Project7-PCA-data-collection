class Sliders {
  ArrayList<Slider> Sliders = new ArrayList<Slider>();
  int Amount;
  int[] Values;

  Sliders(String[] Questions) {
    this.Amount=Questions.length;
    for (int i=0; i<this.Amount; i++) {
      Sliders.add(new Slider(40, 140+i*100, width-300, Questions[i]));
    }
    Values = new int[Sliders.size()];
  }

  boolean CheckIfAllAreAssesed() {
    for (int i = 0; i<Sliders.size(); i++) {
      if (!Sliders.get(i).valueSelected) {
        return false;
      }
    }
    return true;
  }

  void Draw() {
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255);
    rect(200, 20, width-400, 50, 20);
    fill(0);
    text("I hvor høj grad er følgende smag til stede i øllen?", 100, 0, width-200, 80);
    for (Slider Slider : Sliders) {
      Slider.Draw();
    }
  }

  void MouseReleased() {
    for (Slider Slider : Sliders) {
      Slider.MouseReleased();
    }
  }
}



//Backup
/*class Sliders {
 ArrayList<Slider> Sliders = new ArrayList<Slider>();
 int Amount;
 
 Sliders(int Amount) {
 this.Amount=Amount;
 for (int i=1; i<1+Amount; i++) {
 Sliders.add(new Slider(40.0, i*90.0, 400.0, "Goddag"));
 }
 }
 
 void Draw() {
 for (Slider Slider : Sliders) {
 Slider.Draw();
 }
 getValues();
 }
 
 int[]  getValues() {
 int[] Values = new int[Sliders.size()];
 
 for (int i = 0; i < Amount; i++) {
 Slider Slider = Sliders.get(i);
 
 Values[i]=Slider.GetValue()+1;
 }
 
 for (int i = 0; i < Amount; i++) {
 print(Values[i]+"+");
 }
 println();
 
 return Values;
 }
 }
 */
