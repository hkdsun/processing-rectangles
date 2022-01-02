import processing.pdf.*;
import grab.*;
Grab grab = new Grab(this);

import interfascia.*;

GUIController c;
IFButton b1, b2, b3, b4, b5;

Rectangle r;
boolean rainbow = false;
color bg;
color c1, c2;

void setup() {
  size(800, 800);
  pixelDensity(2);
  colorMode(HSB);
  bg = color(230);
  c1 = #0000ffff;
  c2 = #0000ffff;

  r = new Rectangle(90, 90, 650, 650);

  c = new GUIController (this);

  IFLabel row1 = new IFLabel("Background color", 10, 10);

  IFButton bg1 = new IFButton ("Green", 20, 20, 40, 17);
  IFButton bg2 = new IFButton ("Blue", 60, 20, 40, 17);
  IFButton bg3 = new IFButton ("Red", 100, 20, 40, 17);
  IFButton bg4 = new IFButton ("White", 140, 20, 40, 17);

  bg1.addActionListener(this);
  bg2.addActionListener(this);
  bg3.addActionListener(this);
  bg4.addActionListener(this);

  IFLookAndFeel greenLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  greenLook.baseColor = color(100, 180, 100);
  greenLook.highlightColor = color(70, 135, 70);
  greenLook.textColor = color(70, 135, 255);


  c.setLookAndFeel(greenLook);

  c.add(row1);
  c.add(bg1);
  c.add(bg2);
  c.add(bg3);
  c.add(bg4);
}


void draw() {
  background(bg);
  r.fillGradient(c1, c2);

  Vertex centroid = r.centroid();
  Vertex[] vertices = new Vertex[0];
  Line[] sides = new Line[4];
  sides[0] = r.leftSide();
  sides[0] = new Line(sides[0].v2, sides[0].v1);
  sides[1] = r.topSide();
  sides[2] = r.rightSide();
  sides[3] = r.bottomSide();
  sides[3] = new Line(sides[3].v2, sides[3].v1);
  for (int i = 0; i < sides.length; i++) {
    Line side = sides[i];
    Line[] splits = side.split(5);
    for (int j = 0; j < splits.length; j++) {
      vertices = (Vertex[])append(vertices, splits[j].v1);
      if (j == splits.length-1) {
        vertices = (Vertex[])append(vertices, splits[j].v2);
      }
    }
  }

  strokeWeight(0.5);
  stroke(0);
  for (int i = 0; i < vertices.length; i++) {
    Line cL = new Line(centroid, vertices[i]);
    if (rainbow) {
      stroke(i, 200, 200, 255);
    }
    cL._stroke();
  }

  r._stroke();

  // cascade rectangles
  int numCascades = 6;
  Line ctl = new Line(r.centroid(), r.topLeft());
  float cascadeStep = ctl.length()/numCascades/2;
  for (int i = 1; i < numCascades+2; i++) {
    float cascadeDist = cascadeStep*i;
    Rectangle rec = new Rectangle(90+cascadeDist, 90+cascadeDist, 650-cascadeDist*2, 650-cascadeDist*2);
    rec._stroke();
  }

  PImage img;
  img = loadImage("tracy.jpeg");
  image(img, 89*3, 89*3, 652-89*4, 652-89*4);
}


void actionPerformed (GUIEvent e) {
  String label = ((IFButton)e.getSource()).getLabel();
  if (label == "Blue") {
    bg = color(#646482);
    stroke(#649B64);
    tint(#CC5252, 240); // red
    c1 = #5a5a75;
    c2 = #73738e;
  } else if (label == "Green") {
    bg = color(#649B64);
    stroke(#646482);

    tint(#0099CC, 240); // blue

    c1 = #5a8b5a;
    c2 = #73a573;
  } else if (label == "White") {
    bg = color(230);
    stroke(0);
    tint(#0099CC, 240);  // blue
    c2 = #e5e5e5;
    c1 = #b2b2b2;
  } else if (label == "Red") {
    bg = color(#CC5252);
    stroke(0);
    tint(#CCCC52, 240);  // yellow
    c1 = #a34141;
    c2 = #d16363;
  }
}
