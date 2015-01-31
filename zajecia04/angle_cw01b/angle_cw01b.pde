void setup()
{
  size(500,500);
  background(255);
  stroke(50);
  strokeWeight(3);
}

void draw()
{
  background(255);
  line(250,250, mouseX, mouseY);
  float dx = 250-mouseX;
  float dy = 250-mouseY;
  float angle = atan2(dx, dy);
  fill(30);
  float niceAngle = degrees(angle); 
  text(nf(niceAngle, 0,1), 250, 250);
  int c = int((niceAngle+180)/(360/15));
  text("numer ćwiartki = "+str(c), 10, 15);
}
