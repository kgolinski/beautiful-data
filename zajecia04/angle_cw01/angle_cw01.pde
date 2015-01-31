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
  println(radians(angle));
}
