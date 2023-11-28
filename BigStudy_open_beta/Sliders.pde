class Sliders {
  ArrayList<Slider> Sliders = new ArrayList<Slider>();
  int Amount;
  int[] Values;

  Sliders(String[] Questions) {
    this.Amount=Questions.length;
    for (int i=0; i<this.Amount; i++) {
      Sliders.add(new Slider(40, 90+i*100, width-300, Questions[i]));
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
    for (Slider Slider : Sliders) {
      Slider.Draw();
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
