import de.looksgood.ani.*;

Table people;
Table links;
PFont font;

int N;
float textScale = 1.0;
float textScalePrev = 1.0;
float colorScale = 1.0;
int prevSelectedPerson = 0;
int delta = 0;

void setup(){
  Ani.init(this);
  
  size(900,900);
  font = createFont("DINPro-Medium",32);
  textFont(font);
  
  people = loadTable("people.csv");
  N = people.getRowCount();
  
  links = loadTable("links.csv");
  for(int i=0;i<links.getRowCount();i++){
    String linkFrom = links.getString(i,0);
    String linkTo = links.getString(i,1);
    for(int j=0;j<people.getRowCount();j++) 
    {
      if(people.getString(j,0).equals(linkFrom)){
        links.setInt(i,0,j);
      }
      else if(people.getString(j,0).equals(linkTo)){
        links.setInt(i,1,j);
      }
    }
  }
}

void draw()
{
  //obliczam kat do myszki
  float dx = 450-mouseX;
  float dy = 450-mouseY;
  float angle = degrees(atan2(dx, dy));
  //wylicam nr slice
  float sliceSize = 360/N;
  int sliceNr = int((angle+180)/sliceSize);
  
  background(255);
  fill(0);
  strokeWeight(0.5);
  translate(width/2.0,height/2.0);
  noStroke();

  textSize(15);
  text("slice Nr ="+str(sliceNr), -400, -400);
  
  //przeliczam slice na numer osoby
  int selectedPerson;
  if(sliceNr<=12)
    selectedPerson = 12 - sliceNr;
  else
    selectedPerson = N + 12 - sliceNr;

  if(prevSelectedPerson != selectedPerson)
  {
    delta = prevSelectedPerson - selectedPerson;
    prevSelectedPerson = selectedPerson;
    textScale = 1.0;
    textScalePrev = 2.6;
    colorScale = 0.0;
    Ani.to(this, 0.7, "textScale", 2.6);
    Ani.to(this, 0.5, 0.5, "textScalePrev", 1.0);
    Ani.to(this, 0.7, 0.3, "colorScale", 1.0);
    
  }

  textSize(15);
  text("selected Person ="+str(selectedPerson), -400, -380);

  float tSize = 8; 
  float radius=300;
  textSize(tSize);
  for(int i=0;i<people.getRowCount();i++){
    pushMatrix();
    rotate(radians(0.5+i*(360.0/people.getRowCount())));
    translate(radius,0);  
    
    if(i == selectedPerson)
      textSize(textScale*tSize);
    else if( i == selectedPerson+delta)
      textSize(textScalePrev*tSize);
    else
      textSize(tSize);
    
    if(dist(mouseX, mouseY, 450, 450)<50)
    {
      if(people.getString(i,2).equals("male"))
        fill(255,0,0);
      else
        fill(0,255,0);
    }
    else
      fill(0);
    text(people.getString(i,1),0,0);
    popMatrix();
  }
  noFill();
  for(int i=0;i<links.getRowCount();i++){
    int linkFrom = links.getInt(i,0);
    int linkTo = links.getInt(i,1);
    stroke(0,20);
    
    if(linkFrom == selectedPerson)
    {
      stroke(colorScale*255,0,0,100);
    }
    
    float angleFrom = radians(linkFrom*(360.0/people.getRowCount()));
    float angleTo = radians(linkTo*(360.0/people.getRowCount()));
    PVector from = new PVector(radius*cos(angleFrom),radius*sin(angleFrom));
    PVector to = new PVector(radius*cos(angleTo),radius*sin(angleTo));
    
    bezier(from.x, from.y, from.x/2.0, from.y/2.0, 
    to.x/2.0, to.y/2.0, to.x,to.y);    
    
    //line(from.x, from.y, to.x,to.y);    
  }
}
