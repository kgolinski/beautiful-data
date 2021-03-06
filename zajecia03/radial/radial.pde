import processing.pdf.*;

Table people;
Table links;
PFont font;

void setup(){
  size(900,900,PDF,"output.pdf");
  //size(900,900);
  font = createFont("DINPro-Medium",32);
  textFont(font);
  
  people = loadTable("people.csv");
  links = loadTable("links.csv");
  for(int i=0;i<links.getRowCount();i++){
    String linkFrom = links.getString(i,0);
    String linkTo = links.getString(i,1);
    for(int j=0;j<people.getRowCount();j++) 
    {
      if(people.getString(j,0).equals(linkFrom)){
        links.setInt(i,0,j);
       //println(links.getInt(i,0));
      }
      else if(people.getString(j,0).equals(linkTo)){
        links.setInt(i,1,j);
      }
    }
  }
  //noLoop();
}
void draw(){
  background(255);
  fill(0);
  strokeWeight(0.5);
  translate(width/2.0,height/2.0);
  noStroke();
  float tSize = 6; //(width+0.0)/people.getRowCount();
  float radius=300;
  textSize(tSize);
  for(int i=0;i<people.getRowCount();i++){
    pushMatrix();
    rotate(radians(0.5+i*(360.0/people.getRowCount())));
    translate(radius,0);  
    //rotate(PI/2.0);
    text(people.getString(i,1),0,0);
    popMatrix();
  }
  noFill();
  for(int i=0;i<links.getRowCount();i++){
    int linkFrom = links.getInt(i,0);
    int linkTo = links.getInt(i,1);
    stroke(0,20);
    if(linkFrom == 25 || linkTo == 25){
      stroke(255,0,0,100);
    }
    float angleFrom = radians(linkFrom*(360.0/people.getRowCount()));
    float angleTo = radians(linkTo*(360.0/people.getRowCount()));
    PVector from = new PVector(radius*cos(angleFrom),radius*sin(angleFrom));
    PVector to = new PVector(radius*cos(angleTo),radius*sin(angleTo));
    
    bezier(from.x, from.y, from.x/2.0, from.y/2.0, 
    to.x/2.0, to.y/2.0, to.x,to.y);
  }
  exit();
}
