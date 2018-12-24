import java.util.*;

//dynamic arraylist of pasta objects
ArrayList<lineCurves> lineSet;
color first = #D7F0ED;
color second = #417A81;

boolean spaz = false;
boolean addMore = true;
boolean decNL = false;
  
  //pasta color constants
  color white = 255;
  color light = #F2FAF9;
  color dark = #305155;
  color darker = #293E52;
  
  color[] pastaCols = {white, light, dark, darker};
  PFont f;
  Random g = new Random();
    
void setup(){
    //displacement/transformation afar, number of lines,
    lineSet = new ArrayList<lineCurves>();
    lineSet.add(new lineCurves(g.nextInt(5)+6, width/2, height/2));
  
    size(1000,700);
    setBackGradient(0, 0, width, height, first,  second, 1);
    f = createFont("DrumagStudioNF.ttf", 50);
    textFont(f);
    
  }
  
  //continously moves the pasta
   void draw(){
     setBackGradient(0, 0, width, height, first,  second, 1);
     drawType();
     
    for(lineCurves line: lineSet){        
        line.spazMet = spaz;       
        line.draw(); 
    }
   }
   
   //method for typing
   void drawType() {
     textAlign(CENTER);
     fill(#4D5D6A);
     text("Dancing Pasta", width/2, 50);
   
  }
   
   //if mouseClicked, more or less pasta added
   void mouseClicked() {
     int size = lineSet.size();
   if(mouseButton == RIGHT && size > 0) 
     lineSet.remove(size-1);
     
    else{    
        if (addMore)
          lineSet.add(new lineCurves(g.nextInt(5)+6));
          
        else
          lineSet.remove(size-1);
        
        //max
        if(size == 200)
          addMore = false;
          
        else if(lineSet.size() == 0)
          addMore = true;
    }
  }
  
  //if enter is pressed, it SPAZZES
  void keyPressed() {
    
    if(key == ENTER)
      spaz = !spaz;
  }
   
  //makes the background
  void setBackGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    noFill();
  
    if (axis == 1) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    } 
    
    else if (axis == 2) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
    
  }

//makes an object for each set of lines
class lineCurves{
  
  //t is parameter time
  float t;
  int numLines;
  color pastaCol;
  boolean spazMet;
  
  //arrays of randomized values
  int[] randomFactsM;
  int[] randomFactsD;

  //things to randomize the methods
  int methodRand1;
  int methodRand2;
  
  int translateX;
  int translateY;
 
   int displX;
   int displY;

  lineCurves(int nl, int x, int y){
     displX = x;
     displY = y;
   
      pastaCol = pastaCols[g.nextInt(4)];
      randomFactsM = new int[6];
      randomFactsD = new int[4];
      
      //randomly generating the values
      for(int i = 0 ; i < 6 ; i++){
         int posOrNeg = 1;
            
         if(g.nextInt(2) == 1)
            posOrNeg = -1;
                
         randomFactsM[i] = posOrNeg * (g.nextInt(250)+50);
      }
          
      for(int i = 0 ; i < 4 ; i++)
          randomFactsD[i] = 10 * (g.nextInt(5)+ 1);
    
        numLines = nl;
  }
  
  lineCurves(int nl){
    this(nl, mouseX, mouseY);
  }
  
  void draw(){
    //framerate can be 20-1000
    frameRate(1000);
 
    stroke(pastaCol);
    strokeWeight(5);

    for(int i = 0 ; i < numLines; i++)
      //first x coordinate, next x coordinate
      if(spaz)
        line (x1ver2(t+i), y1ver2(t+i), x2ver2(t+i), y2ver2(t+i));
      
      else
       line (x1(t+i), y1(t+i), x2(t+i), y2(t+i));

    t++;
  }
  
  //main parametric equation methods  
    private float x1(float t){
    return displX+ (sin(t/randomFactsD[1])*randomFactsM[1]);
  }
  
  private float y1(float t){
          
    return displY + cos(t/randomFactsD[2])*randomFactsM[2];
  }
  
  private float x2(float t){
          
    return displX + sin(t/randomFactsD[3])*randomFactsM[3];
  }
  
  private float y2(float t){
    
    return displY + cos(t/randomFactsD[0])*randomFactsM[4];
  }
  
  //"funky" version 2 methods that make the pasta more scattery
  private float x1ver2(float t){
     return displX + (sin(t/randomFactsD[1])*randomFactsM[1]) + sin(t/ randomFactsD[3]) * randomFactsD[0];
  }
  
  private float y1ver2(float t){
    return displY + cos(t/randomFactsD[2])*randomFactsM[5] + cos(t)*randomFactsD[1];
  }
  
  private float x2ver2(float t){
    return displX + sin(t/randomFactsD[3])*randomFactsM[3] + sin(t)*randomFactsD[0];
  }
  
  private float y2ver2(float t){
    return displY + cos(t/randomFactsD[0])*randomFactsM[1] + cos(t/randomFactsD[3])*randomFactsM[5];
  }
  
}
