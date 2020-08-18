import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
boolean once=true;

ArrayList<Particle> list;


float xPos = 400;
float yPos = 0;
float yPos2 = 0;
void setup() {

  size(800, 800);
  background(0);

  list = new ArrayList<Particle>();

  minim = new Minim(this);
  player = minim.loadFile("sample.mpeg");
  player.loop();

  colorMode(HSB, 360, 100, 100);
}


void draw() {
  background(0);
  visual();
}




void visual() {

  float ampLeft = abs(player.left.get(0));
  float ampRight = abs(player.right.get(0));
  float ampSum = ampLeft + ampRight;

  yPos = height/2+(ampSum*height);
  yPos2 = width/2-(ampSum*height);

  Particle tmp = new Particle(xPos, yPos, ampSum*100);
  Particle tmp2 = new Particle(xPos, yPos2, ampSum*100);

  list.add(tmp);
  list.add(tmp2);

  //display particles
  for (int j = 0; j<list.size(); j++) {
    noStroke();
    float hue = 360 * sqrt( sq(list.get(j).x - width/2) + sq(list.get(j).y - height/2) ) / max(width/2, height/2);

    fill(hue, 100, 100);
    circle(list.get(j).x, list.get(j).y, list.get(j).size);
    circle(width-list.get(j).x, list.get(j).y, list.get(j).size);
  }

  //Move Points to the left
  for (int i = 0; i<list.size(); i++) {
    if (list.get(i).x == 0 || list.get(i).x == 800) {
      list.remove(i);
    } else {
      list.get(i).x = list.get(i).x -1;
    }
  }
}
